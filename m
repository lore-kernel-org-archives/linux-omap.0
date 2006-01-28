From: Tony Lindgren <tony@atomide.com>
Subject: Re: Command Time-Out values in MMC
Date: Sat, 28 Jan 2006 14:14:01 -0800
Message-ID: <20060128221401.GC23158@atomide.com>
References: <fb249edb0601281148g745d146cy@mail.gmail.com>
	<20060128203624.GD17374@atomide.com>
	<fb249edb0601281341t2228cdect@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <fb249edb0601281341t2228cdect@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: andrzej zaborowski <balrogg@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* andrzej zaborowski <balrogg@gmail.com> [060128 13:41]:
> On 28/01/06, Tony Lindgren <tony@atomide.com> wrote:
> > As far as I remember we're not using the command timeout currently and it
> > was expiring with some cards and causing false errors.
> >
> 
> The value 0 could be used to disable timing out.

Using a reasonably long timeout and adding handling for it
would probably be the best option.

Tony
