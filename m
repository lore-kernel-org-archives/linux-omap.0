From: Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>
Subject: Re: [PATCH] omap-i2c: fix incorrect log message when using a device
 tree
Date: Tue, 11 Sep 2012 09:01:55 +0200
Message-ID: <504EE1E3.7040304@epfl.ch>
References: <1346410975-29930-1-git-send-email-florian.vaussard@epfl.ch> <5040AFCC.5060004@ti.com>
Reply-To: florian.vaussard-p8DiymsW2f8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5040AFCC.5060004-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, =?ISO-8859-1?Q?Philippe_R=E9tornaz?= <philippe.retornaz-p8DiymsW2f8@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hello Wolfram,

>> When booting using a device tree, the adapter number is dynamically
>> assigned after the log message is sent.
>> This patch modifies the log message to get a correct adapter id.
>>
>> Applies on 3.6-rc3. Tested on OMAP3 (Gumstix Overo).
>
> Thanks for the fix. Tested successfully on OMAP4 SDP DT boot as well.
>
> [    0.000000] Linux version 3.6.0-rc3-00030-g491038d (bcousson@lnwes3201) (gcc version 4.5.2 (Sourcery G++ Lite 2011.03-41) ) #6 SMP Fri Aug 31 13:50:48 CEST 2012
> [    0.000000] CPU: ARMv7 Processor [411fc092] revision 2 (ARMv7), cr=10c53c7d
> [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
> [    0.000000] Machine: Generic OMAP4 (Flattened Device Tree), model: TI OMAP4 SDP board
> ...
> [    0.667205] omap_i2c i2c.15: bus 0 rev2.4.0 at 400 kHz
> ...
> [    0.768341] omap_i2c i2c.16: bus 1 rev2.4.0 at 400 kHz
> [    0.783905] omap_i2c i2c.17: bus 2 rev2.4.0 at 400 kHz
> [    0.799530] omap_i2c i2c.18: bus 3 rev2.4.0 at 400 kHz
>
>
>> Signed-off-by: Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>
>
> Tested-by: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
> and
> Acked-by: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
>
> Regards,
> Benoit
>

Was this patch picked-up by the i2c-embedded subsystem?

Thank you.

Regards,
Florian
