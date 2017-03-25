From: Felipe Balbi <balbi@kernel.org>
Subject: Re: [PATCH 1/7] usb: dwc3: core: fix dwc3_probe() to not do put_sync when get_sync fails
Date: Sat, 25 Mar 2017 09:52:29 +0200
Message-ID: <87mvc923pe.fsf@linux.intel.com>
References: <cover.1490387086.git.shuahkh@osg.samsung.com> <2238ea52423a83118ab724a96e8f0691ec4ada0b.1490387086.git.shuahkh@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2238ea52423a83118ab724a96e8f0691ec4ada0b.1490387086.git.shuahkh@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, kgene@kernel.org, krzk@kernel.org, javier@osg.samsung.com
Cc: Shuah Khan <shuahkh@osg.samsung.com>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


Hi,

Shuah Khan <shuahkh@osg.samsung.com> writes:
> dwc3_probe() does pm_runtime_put_sync() in its err1 handling when
> pm_runtime_get_sync() fails.  Move the pm_runtime_put_sync() under
> err2 instead as it is used in error paths after pm_runtime_get_sync()
> succeeds.

there's nothing wrong with current code. Read the docs. Even if
pm_runtime_get*() fails, you still need to decrement the usage
counter. pm_runtime_put*() is one way of achieving so.

-- 
balbi
