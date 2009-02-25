From: Thomas Kaiser <v4l@kaiser-linux.li>
Subject: Re: [RFC] How to pass camera Orientation to userspace
Date: Wed, 25 Feb 2009 14:11:11 +0100
Message-ID: <49A5436F.8000908@kaiser-linux.li>
References: <200902180030.52729.linux@baker-net.org.uk> <200902211253.58061.hverkuil@xs4all.nl> <20090223080715.0c97774e@pedra.chehab.org> <200902232237.32362.linux@baker-net.org.uk> <alpine.LNX.2.00.0902231730410.13397@banach.math.auburn.edu> <alpine.LRH.2.00.0902241723090.6831@pedra.chehab.org> <alpine.LNX.2.00.0902241449020.15189@banach.math.auburn.edu> <alpine.LRH.2.00.0902242153490.6831@pedra.chehab.org> <49A4B4FC.9030209@kaiser-linux.li> <alpine.LNX.2.00.0902242341070.15857@banach.math.auburn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <alpine.LNX.2.00.0902242341070.15857@banach.math.auburn.edu>
Sender: linux-media-owner@vger.kernel.org
To: kilgota@banach.math.auburn.edu
Cc: Mauro Carvalho Chehab <mchehab@infradead.org>, Adam Baker <linux@baker-net.org.uk>, Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org, Jean-Francois Moine <moinejf@free.fr>, Hans de Goede <hdegoede@redhat.com>, Olivier Lorin <o.lorin@laposte.net>, Trent Piepho <xyzzy@speakeasy.org>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

 >> Actually, this happens and is happening!

I got OT. I just needed to vent!

Sorry for the spam.

For the sensor mounting, I think the cam knows how the sensor is mounted 
and therefor the driver knows (driver -> first abstraction layer between 
software and hardware). Therefor the drive has to report the sensor 
orientation to user space (read only).

Thomas

PS: May be, I am OT all ready.


