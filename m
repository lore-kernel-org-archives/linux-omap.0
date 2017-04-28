From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/8] arm: omap4: enable CEC pin for Pandaboard A4 and ES
Date: Fri, 28 Apr 2017 08:08:59 -0700
Message-ID: <20170428150859.GI3780@atomide.com>
References: <20170414102512.48834-1-hverkuil@xs4all.nl>
 <20170414102512.48834-2-hverkuil@xs4all.nl>
 <4355dab4-9c70-77f7-f89b-9a1cf24976cf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-media-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4355dab4-9c70-77f7-f89b-9a1cf24976cf@ti.com>
Sender: linux-media-owner@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, Hans Verkuil <hans.verkuil@cisco.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [170428 04:15]:
> On 14/04/17 13:25, Hans Verkuil wrote:
> > From: Hans Verkuil <hans.verkuil@cisco.com>
> > 
> > The CEC pin was always pulled up, making it impossible to use it.
> > 
> > Change to PIN_INPUT so it can be used by the new CEC support.
...

> Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> 
> Tony, can you queue this? It's safe to apply separately from the rest of
> the HDMI CEC work.

Sure will do.

Thanks,

Tony
