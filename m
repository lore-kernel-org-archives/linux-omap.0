From: Sakari Ailus <sakari.ailus@iki.fi>
Subject: Re: [PATCHv6] support for AD5820 camera auto-focus coil
Date: Mon, 8 Aug 2016 11:09:56 +0300
Message-ID: <20160808080955.GA3182@valkosipuli.retiisi.org.uk>
References: <20160517181927.GA28741@amd>
 <20160521054336.GA27123@amd>
 <573FFF51.1000004@gmail.com>
 <20160521105607.GA20071@amd>
 <574049EF.2090208@gmail.com>
 <20160524090433.GA1277@amd>
 <20160524091746.GA14536@amd>
 <20160525212659.GK26360@valkosipuli.retiisi.org.uk>
 <20160527205140.GA26767@amd>
 <20160805102611.GA13116@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160805102611.GA13116@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, patrikbachan@gmail.com, serge@hallyn.com, linux-media@vger.kernel.org, mchehab@osg.samsung.com
List-Id: linux-omap@vger.kernel.org

On Fri, Aug 05, 2016 at 12:26:11PM +0200, Pavel Machek wrote:
> 
> This adds support for AD5820 autofocus coil, found for example in
> Nokia N900 smartphone.

Thanks, Pavel!

Let's use V4L2_CID_FOCUS_ABSOLUTE, as is in the patch. If we get something
better in the future, we'll switch to that then.

I've applied this to ad5820 branch in my tree.

-- 
Cheers,

Sakari Ailus
e-mail: sakari.ailus@iki.fi	XMPP: sailus@retiisi.org.uk
