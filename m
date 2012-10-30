From: David Daney <ddaney.cavm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c-EEPROM: Export memory accessor
Date: Tue, 30 Oct 2012 11:46:17 -0700
Message-ID: <50902079.30406@gmail.com>
References: <1351699009-4217-1-git-send-email-panto@antoniou-consulting.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1351699009-4217-1-git-send-email-panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pantelis Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Koen Kooi <koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>, Matt Porter <mporter-l0cyMroinI0@public.gmane.org>, Russ Dill <Russ.Dill-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 10/31/2012 08:56 AM, Pantelis Antoniou wrote:
> Various platforms need access to the EEPROM in other
> places besides their platform registration callbacks.
> Export the memory accessor to the i2c_client

i2c_clients are *not* intrinsically memory, so adding this to the 
generic i2c_client structure doesn't really make sense.   What would the 
semantics of this interface be with respect to temperature sensors and 
GPIO expanders?

NACK.


> and implement
> it for the at24 driver.
>
> And before you ask, no, the platform callback can't be used
> for anything that depends on DT.

Why can't you just allocate (and populate) a struct at24_platform_data 
for the device if it isn't supplied by whatever created the device?
