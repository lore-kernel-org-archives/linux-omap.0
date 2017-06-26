From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/8] arm: omap4: enable CEC pin for Pandaboard A4 and ES
Date: Mon, 26 Jun 2017 04:07:11 -0700
Message-ID: <20170626110711.GW3730@atomide.com>
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

Tomi,

* Tomi Valkeinen <tomi.valkeinen@ti.com> [170428 04:15]:
> On 14/04/17 13:25, Hans Verkuil wrote:
> > From: Hans Verkuil <hans.verkuil@cisco.com>
> > 
> > The CEC pin was always pulled up, making it impossible to use it.
...

> Tony, can you queue this? It's safe to apply separately from the rest of
> the HDMI CEC work.

So the dts changes are merged now but what's the status of the CEC driver
changes? Were there some issues as I don't see them in next?

Regards,

Tony
