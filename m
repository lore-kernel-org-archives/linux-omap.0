From: Nick Bowler <nbowler@elliptictech.com>
Subject: Re: [PATCH 5/5] ARM: omap4: Kill private do_wfi macro.
Date: Fri, 9 Sep 2011 13:18:08 -0400
Message-ID: <20110909171808.GA24630@elliptictech.com>
References: <1315582012-23507-1-git-send-email-nbowler@elliptictech.com>
	<1315582012-23507-6-git-send-email-nbowler@elliptictech.com>
	<4E6A470E.9010703@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <4E6A470E.9010703@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Santosh <santosh.shilimkar@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 2011-09-09 22:34 +0530, Santosh wrote:
> On Friday 09 September 2011 08:56 PM, Nick Bowler wrote:
> > The do_wfi macro duplicates the functionality of the wfi macro in common
> > ARM code.  Use the common version instead.
> >
> > Signed-off-by: Nick Bowler<nbowler@elliptictech.com>
> > ---
> > Compile tested in both ARM and Thumb-2 mode.
> 
> Thanks but this is already handle in my PM series.

OK, I will drop this patch.

Thanks,
-- 
Nick Bowler, Elliptic Technologies (http://www.elliptictech.com/)
