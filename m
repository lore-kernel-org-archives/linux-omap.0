From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH 04/10] omap_hwspinlock: Replace "hweight_long(i & 0xf) !=
 1" with "!is_power_of_2(i & 0xf)"
Date: Mon, 7 Dec 2015 13:08:24 +0200
Message-ID: <CAK=WgbZGX5zCjDbesh2sNToH3zi10K=ggGKyLgDcXga-FZSLjw@mail.gmail.com>
References: <1449398006-14450-1-git-send-email-zhaoxiu.zeng@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1449398006-14450-1-git-send-email-zhaoxiu.zeng@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On Sun, Dec 6, 2015 at 12:33 PM, Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com> wrote:
>
> From: Zeng Zhaoxiu <zhaoxiu.zeng@gmail.com>
>
> Signed-off-by: Zeng Zhaoxiu <zhaoxiu.zeng@gmail.com>

Please explain why do you think we should make this change.

Btw, the original code used is_power_of_2, but we thought hweight is
more explicit so it was adopted.

Thanks,
Ohad.
