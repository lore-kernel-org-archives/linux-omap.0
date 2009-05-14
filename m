From: Jagadeesh Bhaskar Pakaravoor <jagadeeshbp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] I2C:Moving Register Defines to Header File
Date: Thu, 14 May 2009 16:04:18 +0530
Message-ID: <561678670905140334x3a5588f3i540ee692890e50e@mail.gmail.com>
References: <52671.192.168.10.89.1242133785.squirrel@dbdmail.itg.ti.com>
	 <87hbzqe55y.fsf@deeprootsystems.com>
	 <57428.192.168.10.89.1242203177.squirrel@dbdmail.itg.ti.com>
	 <87octx9lxn.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87octx9lxn.fsf-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Cc: Syed Rafiuddin <rafiuddin.syed-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

> IMO, The regs do not need to move to a separate header unless they will
> be used outside of i2c-omap.c.
>
Would it not be cleaner to move them to a separate header file,
especially considering the fact that we have some 19 registers for
OMAP3 I2C and when we redefine them for OMAP4, there would be 38
(infact 40, including the two new registers) lines of just register
definitions at the top of the file?

--
Jagadeesh
