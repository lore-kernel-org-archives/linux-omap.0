From: Nishanth Menon <menon.nishanth@gmail.com>
Subject: Re: Sample AIC33 loopback test
Date: Sun, 07 Jan 2007 21:59:45 -0600
Message-ID: <45A1C1B1.3010704@gmail.com>
References: <7d8fdf6f0701071950l54a35c9ncaa13895a433691a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <7d8fdf6f0701071950l54a35c9ncaa13895a433691a@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Raghunandan Dhongadi <dk.raghu@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Raghunandan Dhongadi stated on 1/7/2007 9:50 PM:
> Referring the e-mail on the "davinci" mailing list, I wanted to have
> some advice on the following approach.
>
?? can u put in the thread link?
> I have a OMAP2430 application and, I am trying to have the Audio Codec
> AIC31B driver for I2S ( Data channel ) interface on the DSP core side,
> and teh AIC31B driver for I2C ( control channel ) on the ARM code
> side.
I2S on 2430 is supported on McBSP. you can configure it pretty easily,
two options:
1. handle all configuration of mcbsp and data dump to mcbsp from DSP and
handle only the codec configuration from ARM
2. handle configuration of mcbsp and codec from ARM and data dump only
from DSP.
The decision of which depends on the options you do have in your s/w
stack. if u make mcbsp on omap as slave, then you have more flexibility
in configuration.
McBSP configuration wise: depending on the amt of work u'd want to do.
the simple soln, do a arm side playback (if u already have access to the
working drivers), and break it on a ICD, dump the registers... ;)

S/w perspective is interesting, since default oss and alsa assume that
data flows on arm side.. guess u'd have to redirect configuration
commands and data flow seperately... this is another interesting thing
for all of us to solve someday... with multiprocessors on a single die
sharing differing responsibilities on the same external peripheral..
dont think we have a ready made architecture to use at the moment..

Regards,
Nishanth Menon
