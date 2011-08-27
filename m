From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] usb: ehci: fix update qtd->token in qh_append_tds
Date: Sat, 27 Aug 2011 16:11:11 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1108271607150.21403-100000@netrider.rowland.org>
References: <CACVXFVNrck4u3d7EaRwuwSVO9J-_0jDQ07U0PCw55FZUxsCszA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CACVXFVNrck4u3d7EaRwuwSVO9J-_0jDQ07U0PCw55FZUxsCszA@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ming Lei <ming.lei@canonical.com>
Cc: Greg KH <greg@kroah.com>, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Sun, 28 Aug 2011, Ming Lei wrote:

> Looks like there is still another similar problem in qh_link_async():
> the last wmb
> should be changed into mb, because HC will read 'head->hw->hw_next' from qh
> descriptor and this pointer in qh is read only for HC. But this problem can't be
> observed on ARM, since wmb on ARM is same with mb.

It doesn't matter what the HC does -- the wmb() instruction is executed
by the CPU, not the HC.  The point of that instruction is to make sure 
that the

	qh->hw->hw_next = head->hw->hw_next;

line (and all the preceding lines as well) is ordered before the

	head->hw->hw_next = dma;
3C
line.  Since both of these lines are writes, not reads, it suffices to 
use wmb() rather than mb().

Alan Stern
