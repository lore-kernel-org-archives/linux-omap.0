From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] WATCHDOG: use base address from platform resources and
	make 2430 boot again
Date: Thu, 5 Apr 2007 13:13:17 -0700
Message-ID: <200704051313.17697.david-b@pacbell.net>
References: <782515bb0704041855x4ff69d3bp19d386805eaecf16@mail.gmail.com>
	<4614EF05.6050606@gmail.com>
	<5d5443650704050642n2fcebf7dg34b5e94be428de96@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <5d5443650704050642n2fcebf7dg34b5e94be428de96@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Thursday 05 April 2007 6:42 am, Trilok Soni wrote:
> Hi Nishanth,
> 
> On 4/5/07, Nishanth Menon <menon.nishanth@gmail.com> wrote:
> > >
> > good catch.. missed that one.
> 
> Nop. You have only made change in wdt_probe, but missed wdt_remove for
> setting drvdata to NULL. Please do the same there.

Actually drvata is undefined when there's no driver bound to a device.
So nulling it is not needed.  It may make you worry less about memory
leakage (needless worries, right?), and isn't wrong -- not needed though.
