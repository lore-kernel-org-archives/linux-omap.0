From: Komal Shah <komal_shah802003@yahoo.com>
Subject: RE: ALSA with OMAP1510
Date: Fri, 17 Mar 2006 05:06:20 -0800 (PST)
Message-ID: <20060317130620.18513.qmail@web32913.mail.mud.yahoo.com>
References: <9343BE359FA4224CA72A94D8CC362C9C09365D@edpc500.cedt.iisc.ernet.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <9343BE359FA4224CA72A94D8CC362C9C09365D@edpc500.cedt.iisc.ernet.in>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Prakash Narayanan M <mnarayan@cedt.iisc.ernet.in>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

--- Prakash Narayanan M <mnarayan@cedt.iisc.ernet.in> wrote:

> Hai
> 
> I am using TI Innovator OMAP1510 kit (This does not have tsc2101, but
> AIC23 is the codec and ADS7846 touch screen controller). Kernel
> 2.6.14
> toolchain gcc3.4.1. 
> 
> 1) While selecting ALSA in menuconfig (kernel 2.6.14), is it required

Please visit ALSA and OSS (Open Sound System) project webpages. aplay
is a user space application which calls the alsa library functions to
play the wav files. You should not use the raw interface /dev/dsp, as
was the case in OSS. Both are different projects, and you will see 
Open Sound System as deprecated (but still OMAP drivers are available)
in the menuconfig. 

I would suggest you to try OSS first. So you can easily test
with #cat test.wav > /dev/dsp :). 

In Menuconfig

Device Drivers -> Sound -> Sound Card Support -> Open Sound System ->
Open Sound System (Deprecated) -> OMAP Sound Driver -> AIC23 Stereo
codec

and build.



---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
