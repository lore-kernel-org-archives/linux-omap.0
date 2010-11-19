From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Subject: Re: [PATCH 5/5] omap4: l2x0: Enable early BRESP bit
Date: Fri, 19 Nov 2010 18:32:27 +0000
Message-ID: <yw1xfwux411g.fsf@unicorn.mansr.com>
References: <1290187866-26941-1-git-send-email-santosh.shilimkar@ti.com>
	<1290187866-26941-2-git-send-email-santosh.shilimkar@ti.com>
	<1290187866-26941-3-git-send-email-santosh.shilimkar@ti.com>
	<1290187866-26941-4-git-send-email-santosh.shilimkar@ti.com>
	<1290187866-26941-5-git-send-email-santosh.shilimkar@ti.com>
	<1290187866-26941-6-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1290187866-26941-6-git-send-email-santosh.shilimkar@ti.com>
	(Santosh Shilimkar's message of "Fri, 19 Nov 2010 23:01:06 +0530")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: nm@ti.com, mans@mansr.com, tony@atomide.com, khilman@deeprootsystems.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> The AXI protocol specifies that the write response can only
> be sent back to an AXI master when the last write data has been
> accepted. This optimization enables the PL310 to send the write
> response of certain write transactions as soon as the store buffer
> accepts the write address. This behavior is not compatible with
> the AXI protocol and is disabled by default. You enable this
> optimization by setting the Early BRESP Enable bit in the
> Auxiliary Control Register (bit [30]).

Did you measure the performance difference this makes, if any?

-- =

M=E5ns Rullg=E5rd
mans@mansr.com
