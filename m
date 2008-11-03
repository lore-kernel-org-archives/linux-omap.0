From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/4] HSMMC: Add support for the second controller
Date: Mon, 3 Nov 2008 15:22:27 -0800
Message-ID: <20081103232225.GO28924@atomide.com>
References: <1225418657-31775-1-git-send-email-tony@atomide.com> <200810302012.35317.david-b@pacbell.net> <5e088bd90810302105n1132c280ga39179c057e55c3f@mail.gmail.com> <200810310300.24515.david-b@pacbell.net> <5e088bd90811031454q622f0ad9w274e0225dc885967@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:61925 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752476AbYKCXW3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Nov 2008 18:22:29 -0500
Content-Disposition: inline
In-Reply-To: <5e088bd90811031454q622f0ad9w274e0225dc885967@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: David Brownell <david-b@pacbell.net>, linux-omap@vger.kernel.org

* Steve Sakoman <sakoman@gmail.com> [081103 14:54]:
> On Fri, Oct 31, 2008 at 2:00 AM, David Brownell <david-b@pacbell.net> wrote:
> > On Thursday 30 October 2008, Steve Sakoman wrote:
> >> > Overo has its SDIO WLAN chip (libertas) hard wired to the second controller,
> >> > as I understand things ... or maybe it's the third one.  :)
> >>
> >> Correct!  The wi2wi chip is connected to mmc2 with a 4 bit data path.
> >
> > With the appended patch on top of Tony's four, I get:
> >
> >  mmc1: new SDIO card at address 0001
> >  firmware: requesting sd8686_helper.bin
> >  ...
> >  libertas: can't load helper firmware
> >  libertas: failed to load helper firmware
> >  libertas_sdio: probe of mmc1:0001:1 failed with error -2
> >
> > So, progress.  What's the best place to get that stuff?
> > Do we know that this driver behaves with SDIO yet?
> 
> After a bit more work I now have a wireless connection!
> 
> So I guess we now have confirmation that the driver supports the
> second mmc slot even for SDIO!
> 
> I used David's appended patch plus Tony's 4 HSMMC patches.
> 
> I used version 8.73.7p3 of the Marvell SD8686 firmware and helper
> binaries and placed them in /lib/firmware.

Good to hear! I'll update the patches to change the hsmmc_init()
interface like Dave suggested.

Tony



> 
> The log:
> 
> mmc1: new SDIO card at address 0001
> libertas_sdio: Libertas SDIO driver
> libertas_sdio: Copyright Pierre Ossman
> firmware: requesting sd8686_helper.bin
> firmware: requesting sd8686.bin
> libertas: 00:19:88:05:96:ce, fw 8.73.7p3, cap 0x00000393
> libertas: PREP_CMD: command 0x00a3 failed: 2
> libertas: PREP_CMD: command 0x00a3 failed: 2
> libertas: eth0: Marvell WLAN 802.11 adap
> <snip>
> root@overo:~# iwconfig eth0 essid any
> root@overo:~# ifconfig eth0 up
> root@overo:~# iwlist eth0 scan
> eth0      Scan completed :
>           Cell 01 - Address: 00:19:5B:48:16:C3
>                     ESSID:"dlink"
>                     Mode:Managed
>                     Frequency:2.437 GHz (Channel 6)
>                     Quality=85/100  Signal level=-65 dBm  Noise level=-88 dBm
>                     Encryption key:off
>                     Bit Rates:1 Mb/s; 2 Mb/s; 5.5 Mb/s; 11 Mb/s; 6 Mb/s
>                               12 Mb/s; 24 Mb/s; 36 Mb/s; 9 Mb/s; 18 Mb/s
>                               48 Mb/s; 54 Mb/s
>           Cell 02 - Address: 00:03:93:EA:69:AD
>                     ESSID:"Millville"
>                     Mode:Managed
>                     Frequency:2.457 GHz (Channel 10)
>                     Quality=98/100  Signal level=-30 dBm  Noise level=-88 dBm
>                     Encryption key:off
>                     Bit Rates:1 Mb/s; 2 Mb/s; 5.5 Mb/s; 11 Mb/s; 6 Mb/s
>                               9 Mb/s; 12 Mb/s; 18 Mb/s; 24 Mb/s; 36 Mb/s
>                               48 Mb/s; 54 Mb/s
> 
> root@overo:~# udhcpc eth0
> udhcpc (v1.11.3) started
> run-parts: /etc/udhcpc.d/00avahi-autoipd exited with code 1
> Sending discover...
> Sending select for 192.168.0.22...
> Lease of 192.168.0.22 obtained, lease time 86400
> run-parts: /etc/udhcpc.d/00avahi-autoipd exited with code 1
> adding dns 66.133.189.215
> adding dns 216.67.192.3
> root@overo:~# ping gumstix.com
> PING gumstix.com (216.139.227.50): 56 data bytes
> 64 bytes from 216.139.227.50: seq=0 ttl=50 time=132.721 ms
> 64 bytes from 216.139.227.50: seq=1 ttl=50 time=132.233 ms
> 64 bytes from 216.139.227.50: seq=2 ttl=50 time=147.369 ms
> 
> --- gumstix.com ping statistics ---
> 3 packets transmitted, 3 packets received, 0% packet loss
> round-trip min/avg/max = 132.233/137.441/147.369 ms
> root@overo:~#
