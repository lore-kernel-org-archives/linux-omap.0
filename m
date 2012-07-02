From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 2/2] remoteproc: remove the now-redundant kref
Date: Mon, 2 Jul 2012 09:59:11 +0100
Message-ID: <20120702085911.GA16639@n2100.arm.linux.org.uk>
References: <1338017791-9442-1-git-send-email-ohad@wizery.com> <1338017791-9442-2-git-send-email-ohad@wizery.com> <4FC5DD74.4030202@codeaurora.org> <CAK=WgbbwaMAnTGcivC9ZR8K-MtTqHAV3+BgUmk8WjCaayifJxw@mail.gmail.com> <4FCD272E.1020300@codeaurora.org> <CAK=WgbZu1hYOd27r259b2v48VFYeOZ4UE5sD2awZDxgBgjAsXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAK=WgbZu1hYOd27r259b2v48VFYeOZ4UE5sD2awZDxgBgjAsXw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Fernando Guzman Lugo <fernando.lugo@ti.com>
List-Id: linux-omap@vger.kernel.org

On Mon, Jul 02, 2012 at 11:52:27AM +0300, Ohad Ben-Cohen wrote:
> Simplify the unregister/free interfaces, and make them easier
> to understand and use, by moving to a symmetric and consistent
> alloc() -> register() -> unregister() -> free() flow.

The naming in the driver model is:

alloc() -> add() -> del() -> put()

where alloc() is an allocation + initialization, and

register() -> unregister()

where register() is initialization + add() and
unregister() is del() + put().
