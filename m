From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: [PATCH] OMAP3 clock: fix omap2_clk_wait_ready for OMAP3430ES2 DSS
Date: Sun, 22 Jun 2008 15:21:38 +0200
Message-ID: <F3AD2E5C-9017-4B0D-9B68-C199A511B0BB@student.utwente.nl>
References: <5A47E75E594F054BAF48C5E4FC4B92AB022BE46296@dbde02.ent.ti.com>,<485CA347.909@googlemail.com> <5A47E75E594F054BAF48C5E4FC4B92AB022BB66209@dbde02.ent.ti.com> <alpine.DEB.1.00.0806211054100.19765@utopia.booyaka.com> <ACAEC52B-E9B4-4789-8D63-114C53846760@student.utwente.nl> <13B9B4C6EF24D648824FF11BE8967162035BA2A659@dlee02.ent.ti.com>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1.utsp.utwente.nl ([130.89.2.8]:55914 "EHLO smtp.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751739AbYFVN0A (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 22 Jun 2008 09:26:00 -0400
Received: from [172.20.1.5] (vpn006061.vpn.utwente.nl [130.89.6.61])
          by smtp.utwente.nl (8.12.10/SuSE Linux 0.7) with ESMTP id m5MDLeWU006122
          for <linux-omap@vger.kernel.org>; Sun, 22 Jun 2008 15:21:41 +0200
In-Reply-To: <13B9B4C6EF24D648824FF11BE8967162035BA2A659@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Op 22 jun 2008, om 14:51 heeft Woodruff, Richard het volgende  
geschreven:

>
>> PowerTOP version 1.10      (C) 2007 Intel Corporation
>>
>> Cn                Avg residency       P-states (frequencies)
>> C0 (cpu running)        ( 0.0%)
>> C0                0.0ms ( 0.0%)
>> C1              188.9ms (0.7%)*
>> C2              2036.1ms (8.0%)*
>> C3              23285.1ms (91.3%)*
>>
>> Wakeups-from-idle per second : 61.7     interval: 3.0s
>>
>> Top causes for wakeups:
>>   44.9% ( 57.7)       <interrupt> : musb_hdrc.0
>>   17.9% ( 23.0)       <interrupt> : gp timer
>>   14.3% ( 18.3)   USB device 2-1.2 : LCD2USB Interface (Till Harbaum)
>>    9.9% ( 12.7)         lcd4linux : do_nanosleep (hrtimer_wakeup)
>>    7.5% (  9.7)   USB device 2-1.4 : Linksys USB2.0 Network Adapter
>> (USB)
>>    3.9% (  5.0)            Xfbdev : fbcon_add_cursor_timer
>> (cursor_timer_handler)
>>    0.5% (  0.7)              hald : schedule_timeout  
>> (process_timeout)
>>    0.3% (  0.3)          dropbear : sk_reset_timer (tcp_write_timer)
>>    0.3% (  0.3)     <kernel core> : neigh_table_init_no_netlink
>> (neigh_periodic_timer)
>>    0.3% (  0.3)        pulseaudio : schedule_timeout  
>> (process_timeout)
>>    0.3% (  0.3)              init : schedule_timeout  
>> (process_timeout)
>>
>> The dispc crashes are gone and I get fewer wakeups per second :)
>>
>> regards,
>>
>> Koen
>>
>>
>> * There's a bug in powertop 1.10 that reports percentages wrong, so
>> the percentages  where approximated by hand.
>>
>> C0 (cpu running)        ( 0.0%)
>> C0                0.0ms ( 0.0%)
>> C1              176.5ms ( 4.7%)
>> C2              3601.7ms (4090.7%)
>> C3              17956.3ms (92938.0%)
>
> Those C-State residency times are clearly wrong also.
>
> If you try hard with a minimal kernel the maximum sleep you can get  
> is like 1.5 seconds.  The kernel has some hard coded timers with 1  
> to 2 second periods (like slab cache reaper threads).
>
> For our non-edge kernel code these things report about right.  As  
> long as you have a 99.9% duty cycle of OFF to ON you get pretty good  
> savings.
>
> The wake up information should be about right.  Your USB Networking  
> with MUSB will probably assure you of never getting ultra low power  
> numbers but probably good for development.
>
> What is that USB2LCD device?

http://www.harbaum.org/till/lcd2usb/index.shtml driven by the  
lcd4linux app, which is quite x86 oriented, so not very powersaving  
friendly, I did save ~100 wake-ups/s by using libusb1+libusbcompat  
over libusb.

regards,

Koen

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFIXlHkMkyGM64RGpERAozNAJwJZy+hqtqAlnEOk4WvZ4zrTkK4uACfbA7x
XQ5GgY6n3vI7cabyVLvQfOY=
=ZheC
-----END PGP SIGNATURE-----
