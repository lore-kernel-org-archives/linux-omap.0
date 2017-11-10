From: Sakari Ailus <sakari.ailus@iki.fi>
Subject: Re: N900 kernel support
Date: Fri, 10 Nov 2017 17:53:24 +0200
Message-ID: <20171110155324.cydwiqnjfmyravac@valkosipuli.retiisi.org.uk>
References: <20171110144519.o2dccswmzdjkfrnt@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171110144519.o2dccswmzdjkfrnt@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, sre@kernel.org, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri, Nov 10, 2017 at 03:45:19PM +0100, Pali Rohár wrote:
> And what happened with ramp mode for camera autofocus?

It's not currently in mainline. That mode is more or less useless for any
decent AF algorithm as it does not implement functionality typically needed
from lens drivers.

I guess you could implement support for it by using custom controls but I
don't think it's really good for anything.

-- 
Sakari Ailus
e-mail: sakari.ailus@iki.fi
