From: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Subject: Re: Artifacts present in AIC23 capture for 48
	KHz	sampling rate
Date: Wed, 18 Nov 2009 14:50:08 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB030A9CA9D0@dbde02.ent.ti.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB030A8C9109@dbde02.ent.ti.com>
	<4B02F4E1.3060405@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <4B02F4E1.3060405@boundarydevices.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Troy Kisky <troy.kisky@boundarydevices.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

> -----Original Message-----
> From: Troy Kisky [mailto:troy.kisky@boundarydevices.com]
> Sent: Wednesday, November 18, 2009 12:39 AM
> To: Aggarwal, Anuj
> Cc: alsa-devel@alsa-project.org; linux-omap@vger.kernel.org
> Subject: Re: [alsa-devel] Artifacts present in AIC23 capture for 48 KHz
> sampling rate
> 
> Aggarwal, Anuj wrote:
> >> -----Original Message-----
> >> From: Aggarwal, Anuj
> >> Sent: Friday, November 06, 2009 6:28 PM
> >> To: alsa-devel@alsa-project.org; 'linux-omap@vger.kernel.org'
> >> Subject: Artifacts present in AIC23 capture for 48 KHz sampling rate
> >>
> >> Hi,
> >>
> >> I am observing artifacts (sharp spikes at fixed intervals) while
> >> capturing audio on AM3517 EVM and AIC23 codec. They are present only
> >> in one of the channels when I am capturing at 48 KHz. All other
> >> sampling rates are working fine with the above said combination.
> >>
> >> I have also attached the screenshot taken with the help of Audacity
> >> utility. Here, I tried recording silence but artifacts were observed
> >> on one channel.
> >>
> >> Has anyone also observed the similar behavior with AIC23 codec? Any
> >> hints on what could be the root cause?
> > [Aggarwal, Anuj] On further debugging, I found that the function
> > find_rate() in sound/soc/codecs/tlv320aic23.c is not returning
> > the correct value for capture in 48KHz sample rate. In USB mode
> > (MCLK=12MHz), for 48KHz, it returns 0x7D (CLKOUT=0, CLKIN=1,
> > SR[3:0]=0xF, BOSR=1, Normal=1) whereas as per the AIC23B spec,
> 
> 0x7D would be BOSR = 0, USB/NORMAL = 1, SR=0xff, div2 = 1
> 
> The bug is with sr_valid_mask,
> 
> static const unsigned short sr_valid_mask[] = {
> 	LOWER_GROUP|UPPER_GROUP,	/* Normal, bosr - 0*/
> 	LOWER_GROUP|UPPER_GROUP,	/* Normal, bosr - 1*/
> 	LOWER_GROUP,			/* Usb, bosr - 0*/
> 	UPPER_GROUP,			/* Usb, bosr - 1*/
> };
> 
> should be
> 
> static const unsigned short sr_valid_mask[] = {
> 	LOWER_GROUP|UPPER_GROUP,	/* Normal, bosr - 0*/
> 	LOWER_GROUP,			/* Usb, bosr - 0*/
> 	LOWER_GROUP|UPPER_GROUP,	/* Normal, bosr - 1*/
> 	UPPER_GROUP,			/* Usb, bosr - 1*/
> };
> 
> 
> Can you give this a try and let me know?
[Aggarwal, Anuj] I tried this on AM3517 EVM + AIC23B; it works
fine for me. But I have tested the fix only with a 12 MHz clock.
Thanks for quickly fixing this.
> 
> Thanks
> Troy
> 
