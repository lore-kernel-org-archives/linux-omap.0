From: lamikr <lamikr-Zylw9I2HBCb1KXRcyAk9cg@public.gmane.org>
Subject: Re: [Familiar] help me
Date: Mon, 27 Nov 2006 03:50:32 +0200
Message-ID: <456A4468.40001@cc.jyu.fi>
References: <BAY102-F27D515FA32733EE854FFB4D3E70@phx.gbl>
Reply-To: lamikr-Zylw9I2HBCb1KXRcyAk9cg@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <kernel-discuss-bounces-CN5wO63fgwogsBAKwltoeQ@public.gmane.org>
In-Reply-To: <BAY102-F27D515FA32733EE854FFB4D3E70-MsuGFMq8XAE@public.gmane.org>
List-Unsubscribe: <https://handhelds.org/mailman/listinfo/kernel-discuss>,
	<mailto:kernel-discuss-request-CN5wO63fgwogsBAKwltoeQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://www.handhelds.org/hypermail/kernel-discuss/current>
List-Post: <mailto:kernel-discuss-CN5wO63fgwogsBAKwltoeQ@public.gmane.org>
List-Help: <mailto:kernel-discuss-request-CN5wO63fgwogsBAKwltoeQ@public.gmane.org?subject=help>
List-Subscribe: <https://handhelds.org/mailman/listinfo/kernel-discuss>,
	<mailto:kernel-discuss-request-CN5wO63fgwogsBAKwltoeQ@public.gmane.org?subject=subscribe>
Sender: kernel-discuss-bounces-CN5wO63fgwogsBAKwltoeQ@public.gmane.org
Errors-To: kernel-discuss-bounces-CN5wO63fgwogsBAKwltoeQ@public.gmane.org
To: ahmed nabel <a_n_alazzawi-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Cc: linux-omap-open-source-P3Mejjx7fphMeHKdZgrLhA@public.gmane.org, familiar-CN5wO63fgwogsBAKwltoeQ@public.gmane.org, kernel-discuss-CN5wO63fgwogsBAKwltoeQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

ahmed nabel wrote:
> hello
>
> I have successfuly installed the Linux on my 6340 iPAQ, following the
> instructions on:
>
> http://aragorn.kortex.jyu.fi:8080/h6300/H6300_Boot.html
>
> and its very cool. Thank you all.
Well, thank's for yourself for testing.
>
> However I have two problems:
>
> 1. The phone can not work. When I try to modify the buttons settings,
> so that i choose one of them for the phone, i can not see the phone as
> an option in the list available... However, the system info reads the
> device correctly as h6300 series...
You will need to enable the phone in wince before booting to Linux. (No
need to make calls, just turn the module on)
>
> 2. I can not shut down the device. The power button does not work and
> the suspend option in the start menu causes the the system to halt and
> make a loud noies, so then I have to hardware reset the device, which
> goes back to WinCe
Hi

There are little newer versions from following stuffs available in the
following url than what are linked in www page.
I have not changed the links in documents  point to this version as I
want to get the battery monitor support added to next "official" image.
These versions are anyway tested by quite many, so I suggest testing
with the following.

- gpe-image:  (based on to familiar 0.84 but with newer kernel to
support suspend/resume, gomunicator, key bindings and apmd.)
http://aragorn.kortex.jyu.fi:8080/h6300/snapshots/binaries/gpe/h6300_gpe_image_20061003.tar.bz2

- wililo: (wince lilo) bootloader which allows user to select between
multiple different boot configurations. Extract this to fat partition in
SD/MMC on top of the original and launch the "wililo.exe". Note that the
"third" telnet option in the list does not currently work.
http://aragorn.kortex.jyu.fi:8080/h6300/snapshots/binaries/gpe/wililo.tar.bz2

- gprs scripts configured with following options: apn=internet, no
authentication needed, routing table updated.
Extract these to h6300 ext2 partition and launch by using command
"/usr/sbin/pppd call gprs".
http://aragorn.kortex.jyu.fi:8080/h6300/snapshots/binaries/gprs/sonera_gprs_settings_v2.tar.bz2

Note
1) Gomunicator works in this version as an applet. So keep the pen down
in the panel for a while and select then "add gomunicator" to add it to
panel.
    After this you can hide/view the gomunicator by clicking it's icon
in the panel.
2) Currently gomunicator can not be open while using gprs connection
with pppd. We are trying to fix this by usings wavecom's multiplexer
    as a help. Plan is that the gprs connection establishment (atdt*99)
would be made with gomunicator talking to multiplexed AT command
channel. Once
    the communication would be ready, pppd could propably be connected
directly to multiplexed data channel. We have not yet verified whether
this will work    with the unmodified pppd...

If you are interested in from the development, try to contact us from
the h6300-port irc channel...

Mika
