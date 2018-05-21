From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 02/33] mfd: omap-usb-host: use match_string() helper
Date: Mon, 21 May 2018 10:41:16 -0700
Message-ID: <20180521174116.GB98604@atomide.com>
References: <1526903890-35761-1-git-send-email-xieyisheng1@huawei.com>
 <1526903890-35761-3-git-send-email-xieyisheng1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1526903890-35761-3-git-send-email-xieyisheng1@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yisheng Xie <xieyisheng1@huawei.com>
Cc: linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Yisheng Xie <xieyisheng1@huawei.com> [180521 12:11]:
> match_string() returns the index of an array for a matching string,
> which can be used intead of open coded variant.

Looks OK to me:

Acked-by: Tony Lindgren <tony@atomide.com>
