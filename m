From: Tony Lindgren <tony@atomide.com>
Subject: Re: H4 boot with latest git kernel
Date: Fri, 9 Feb 2007 08:51:58 -0800
Message-ID: <20070209165157.GB22121@atomide.com>
References: <5d5443650702090324g6048af71u17f20a55f823edda@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <5d5443650702090324g6048af71u17f20a55f823edda@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Trilok Soni <soni.trilok@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Trilok Soni <soni.trilok@gmail.com> [070209 03:30]:
> Hi,
> 
> H4 booting sequence stops just after the following NET messages. I am
> using latest pull from git. I have tried disabling IrDA, thinking that
> it might had created some problems. Is it working for anyone out
> there?

Maybe try booting with initcall_debug kernel parameter to see where
it hangs?

Regards,

Tony
