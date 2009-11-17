From: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Subject: Re: Artifacts present in AIC23 capture for 48 KHz
	sampling rate
Date: Tue, 17 Nov 2009 18:45:52 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB030A8C9109@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
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
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "troy.kisky@boundarydevices.com" <troy.kisky@boundarydevices.com>
List-Id: linux-omap@vger.kernel.org

> -----Original Message-----
> From: Aggarwal, Anuj
> Sent: Friday, November 06, 2009 6:28 PM
> To: alsa-devel@alsa-project.org; 'linux-omap@vger.kernel.org'
> Subject: Artifacts present in AIC23 capture for 48 KHz sampling rate
> 
> Hi,
> 
> I am observing artifacts (sharp spikes at fixed intervals) while
> capturing audio on AM3517 EVM and AIC23 codec. They are present only
> in one of the channels when I am capturing at 48 KHz. All other
> sampling rates are working fine with the above said combination.
> 
> I have also attached the screenshot taken with the help of Audacity
> utility. Here, I tried recording silence but artifacts were observed
> on one channel.
> 
> Has anyone also observed the similar behavior with AIC23 codec? Any
> hints on what could be the root cause?
[Aggarwal, Anuj] On further debugging, I found that the function
find_rate() in sound/soc/codecs/tlv320aic23.c is not returning 
the correct value for capture in 48KHz sample rate. In USB mode
(MCLK=12MHz), for 48KHz, it returns 0x7D (CLKOUT=0, CLKIN=1, 
SR[3:0]=0xF, BOSR=1, Normal=1) whereas as per the AIC23B spec, 
it should have been 0x5D (CLKOUT=0, CLKIN=1, SR[3:0]=0x7, 
BOSR=1, Normal=1). When I forcefully write the above said value
to the Sample Rate Control register, things work fine for me
for 48KHz capture.
Is my understanding correct for this problem? Can someone help
me understand how the function calculates the appropriate value?
> 
> Regards,
> Anuj Aggarwal
