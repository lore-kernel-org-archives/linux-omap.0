From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH] remoteproc/wkup_m3: Use MODULE_DEVICE_TABLE to export alias
Date: Thu, 26 Nov 2015 11:44:01 +0200
Message-ID: <CAK=Wgbb_y=bAG6fPqv-w3Dd85jqAyGL25UMjrFQbwWzNk-awjQ@mail.gmail.com>
References: <1442406774-13260-1-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1442406774-13260-1-git-send-email-d-gerlach@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: linux-arm <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Suman Anna <s-anna@ti.com>
List-Id: linux-omap@vger.kernel.org

On Wed, Sep 16, 2015 at 3:32 PM, Dave Gerlach <d-gerlach@ti.com> wrote:
> Use MODULE_DEVICE_TABLE with wkup_m3_rproc_of_match so the module alias
> is exported and the wkup_m3_rproc driver can automatically probe.
>
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>

Applied to remoteproc-next, thanks.
