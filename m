From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] misc. OMAP PM updates for v3.1
Date: Mon, 27 Jun 2011 04:28:43 -0700
Message-ID: <20110627112843.GN23145@atomide.com>
References: <87vcvw5akk.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <87vcvw5akk.fsf@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kevin Hilman <khilman@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Kevin Hilman <khilman@ti.com> [110623 17:32]:
> Tony,
> 
> Please pull the following misc. OMAP PM updates targetted for v3.1.
> 
> This branch is based on your 'fixes' branch due to some dependencies.
>       OMAP2: PM debug: move wakeup timer into clockevent code

This won't work with the devel-timer branch. I think we should just
drop it for now based on what I mentioned in the other thread.

Regards,

Tony
