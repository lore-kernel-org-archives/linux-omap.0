From: Nishanth Menon <menon.nishanth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH][RFC] OMAP4: I2C Support for OMAP_4430SDP
Date: Fri, 29 May 2009 20:52:01 +0300
Message-ID: <782515bb0905291052h1d70be5em7cfdeeda903c39fc@mail.gmail.com>
References: <55272.192.168.10.89.1243607905.squirrel@dbdmail.itg.ti.com>
	 <878wkghqzi.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <878wkghqzi.fsf-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Cc: Syed Rafiuddin <rafiuddin.syed-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Fri, May 29, 2009 at 6:24 PM, Kevin Hilman
<khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org> wrote:
> "Syed Rafiuddin" <rafiuddin.syed-l0cyMroinI0@public.gmane.org> writes:
>> +static int __init omap4_i2c_init(void)
>> +{
>> + =A0 =A0 omap_register_i2c_bus(1, 2600, NULL, 0);
why is this 2600? omap3 could do 3.3Mhz.

>> + =A0 =A0 omap_register_i2c_bus(2, 400, NULL, 0);
>> + =A0 =A0 omap_register_i2c_bus(3, 400, NULL, 0);
>> + =A0 =A0 return 0;
>> +}

This code badly worries me given the omap3 story and i2c bus
capacitance. The new code for omap4 should allow for scll and sclh to
be board specific configurable [1] and [2] - i would expect a similar
story kicking in again...
Regards,
Nishanth Menon
Ref:
[1] http://marc.info/?t=3D123540865900002&r=3D1&w=3D2
[2] http://marc.info/?t=3D123457935200001&r=3D1&w=3D2
