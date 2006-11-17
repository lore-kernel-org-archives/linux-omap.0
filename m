From: "Abot Botbot" <dejanigma@hotmail.com>
Subject: RE: Using audio on OMAP OSK5912
Date: Fri, 17 Nov 2006 18:17:23 +0000
Message-ID: <BAY102-F24523908757780FC4A5F50A9E80@phx.gbl>
References: <772F5D89C5E0734B8A86D85DFC6A202405226000@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <772F5D89C5E0734B8A86D85DFC6A202405226000@dlee03.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Folks,

  I thought the only way to interface the audio codec on the 5912 was 
through the GPP side, that the DSP core had no connectivity to this device. 
This required using either DSP/BIOS a-la the RF6 app, or using DSP Gateway, 
both of which transfer the samples over a shared memory interface to the 
DSP. Is this correct?

Thanks,
Andy


>From: "Ishigami, Tatsuya" <ishigami@ti.com>
>To: "Carlos, John J DA CIV USA ATC" <john.carlos@atc.army.mil>
>CC: Linux-Omap-Open-Source <linux-omap-open-source@linux.omap.com>
>Subject: RE: Using audio on OMAP OSK5912
>Date: Fri, 17 Nov 2006 11:50:12 -0600
>
>Hi John,
>
>  Ideally, the OMAP5912 would perform better
>(faster and consumes less power), if the DSP
>both read and process the data.
>
>  This is because (a) the McBSP1 is the DSP's
>peripheral, and (b) the DSP is the processor
>specially designed for signal processing :-)
>
> > Also that is the best way to make sure
> > you are sampling at a set frequency?
>
>  A quick way would be
>
>  1) Record sound with the OSK5912 to a file.
>  2) Transfer the file to PC
>  3) Convert this raw data into WAV format
>     (with the sampling rate & bit-resolution
>      info you set)
>  3) Play the WAV file to hear if it sounds same.
>
>  Regards,
>  Ishigami
>
>-----Original Message-----
>From: Carlos, John J DA CIV USA ATC [mailto:john.carlos@atc.army.mil]
>Sent: Thursday, November 16, 2006 10:48 AM
>To: Linux-Omap-Open-Source
>Subject: Using audio on OMAP OSK5912
>
>Hello All,
>
>   I am seeking advice.  I have seen some emails about using the audio
>chip
>on OSK.  My question: what would be better 1.  Have arm read data from
>aic23
>and DSP process or 2.  have DSp read data and arm process.  I would
>think
>the first would be more desirable.  Also that is the best way to make
>sure
>you are sampling at a set frequency?
>
>Thanks,
>John
>
>_______________________________________________
>Linux-omap-open-source mailing list
>Linux-omap-open-source@linux.omap.com
>http://linux.omap.com/mailman/listinfo/linux-omap-open-source

_________________________________________________________________
Stay up-to-date with your friends through the Windows Live Spaces friends 
list. 
http://clk.atdmt.com/MSN/go/msnnkwsp0070000001msn/direct/01/?href=http://spaces.live.com/spacesapi.aspx?wx_action=create&wx_url=/friends.aspx&mk
