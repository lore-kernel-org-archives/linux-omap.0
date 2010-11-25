From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [RFC/PATCH v6 02/12] media: Media device
Date: Thu, 25 Nov 2010 18:30:39 +0100
Message-ID: <201011251830.40522.laurent.pinchart@ideasonboard.com>
References: <1q7hf5w7lvslx3nba6ooh9j2.1290705631030@email.android.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <1q7hf5w7lvslx3nba6ooh9j2.1290705631030@email.android.com>
Sender: linux-media-owner@vger.kernel.org
To: Andy Walls <awalls@md.metrocast.net>
Cc: Clemens Ladisch <clemens@ladisch.de>, linux-media@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, sakari.ailus@maxwell.research.nokia.com, broonie@opensource.wolfsonmicro.com, lennart@poettering.net
List-Id: linux-omap@vger.kernel.org

Hi Andy,

On Thursday 25 November 2010 18:20:31 Andy Walls wrote:
> The signedness of char is ambiguous for 8 bit data, which is why an API
> would normally use u8 (or s8, I guess).
> 
> Since this is known to be character data, I would think char would be fine.

I think so too.

> I am assuming C compilers would never assume multibyte "char"s.

Not on sane platforms I guess. We would have problems much worse than MC API 
breakage in that case anyway :-)

-- 
Regards,

Laurent Pinchart
