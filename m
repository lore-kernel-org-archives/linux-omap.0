From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH 04/10] omap_hwspinlock: Replace "hweight_long(i & 0xf) !=
 1" with "!is_power_of_2(i & 0xf)"
Date: Mon, 7 Dec 2015 18:16:58 +0200
Message-ID: <CAK=WgbZhhbjOyb0ktsSSsw2s6rw=NDDSJZ0G-84gRKw-J7gy=w@mail.gmail.com>
References: <1449398006-14450-1-git-send-email-zhaoxiu.zeng@gmail.com>
 <CAK=WgbZGX5zCjDbesh2sNToH3zi10K=ggGKyLgDcXga-FZSLjw@mail.gmail.com> <56659FC2.1070906@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56659FC2.1070906@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "zhaoxiu.zeng" <zhaoxiu.zeng@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Dec 7, 2015 at 5:03 PM, zhaoxiu.zeng <zhaoxiu.zeng@gmail.com> wrote:
> is_power_of_2 is simple, and faster than "hweightN(x) == 1" on most architectures.

Thanks. I'm not sure that speed is a major concern here, since this
code executes only once during the lifetime of the driver. Readability
is probably more important.
