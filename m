From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] drm/omap: gem: Fix tearing with BO_TILED
Date: Wed, 8 Jan 2020 08:57:14 -0800
Message-ID: <20200108165714.GI5885@atomide.com>
References: <20191221005711.47314-1-tony@atomide.com>
 <20191221164141.GI35479@atomide.com>
 <20200104050950.GA11429@chinchilla>
 <20200104055011.GA5885@atomide.com>
 <20200105203704.GD5885@atomide.com>
 <20200106180631.GA30670@chinchilla>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <20200106180631.GA30670@chinchilla>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Sebastian Reichel <sre@kernel.org>, dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, "H . Nikolaus Schaller" <hns@goldelico.com>, Merlijn Wajer <merlijn@wizzup.org>
List-Id: linux-omap@vger.kernel.org

* Matthijs van Duin <matthijsvanduin@gmail.com> [200106 10:07]:
> On Sun, Jan 05, 2020 at 12:37:04PM -0800, Tony Lindgren wrote:
> > 4. The issue I'm seeing with stellarium on droid4 may be a stride
> >    issue as about one out of 3 or 4 frames is OK and aligning to
> >    512 also fixes the issue maybe because it happens to make
> >    multiple frames align to 4096
> 
> Yeah if your buffers are 960 pixels wide (assuming the droid4's screen
> is natively portrait) and 32bpp then 512-byte alignment suffices to
> automatically make them 4KB alignment.

Hmm sounds like I need to retest this. But doesn't 512-byte alignment
only make the 960 pixels case 2KB aligned?

> The most obvious thing I can think of that could do wrong is that it
> might contiguously map the pages that cover each line, which is what
> will happen if they use e.g. for_each_sg_page, but subsequently assume
> that the stride in sgx virtual memory is ALIGN( width * cpp, PAGE_SIZE )
> without taking the offset of the buffer inside the mapping into account.

OK

> If each line is at most 4KB (i.e. 1024 pixels @ 32bpp) but each line
> straddles an MMU page boundary, then the result would be that the even
> lines of the frame are written to the top half of the buffer, causing it
> to be scaled to 50% vertically, while the odd lines are "lost" (written
> outside the buffer, either to a different buffer or unmapped tiler
> memory).  This sounds like what you described on irc?

Yes this sounds like what I've been seeing.

Regards,

Tony
