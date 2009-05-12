From: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Subject: Re: [PATCH] I2C:Moving Register Defines to Header File
Date: Tue, 12 May 2009 08:01:45 -0700
Message-ID: <87hbzqe55y.fsf@deeprootsystems.com>
References: <52671.192.168.10.89.1242133785.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <52671.192.168.10.89.1242133785.squirrel-pJFUjGLopx31T2qfsofKZtBPR1lH4CV8@public.gmane.org> (Syed Rafiuddin's message of "Tue\, 12 May 2009 18\:39\:45 +0530 \(IST\)")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Syed Rafiuddin <rafiuddin.syed-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

"Syed Rafiuddin" <rafiuddin.syed-l0cyMroinI0@public.gmane.org> writes:

> This patch creates i2c-omap.h header and moves register and bit definition
> macros to it from i2c-omap.c

Please use the description to describe the motivation for the changes
and the problems it is addressing/fixing. 

In other words, you described what your patch does but not why.

Kevin
