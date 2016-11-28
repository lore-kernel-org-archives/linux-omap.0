From: Yegor Yefremov <yegorslists@googlemail.com>
Subject: Re: [PATCH] cpsw: ethtool: add support for nway reset
Date: Mon, 28 Nov 2016 16:25:38 +0100
Message-ID: <CAGm1_kssM4qZzrLKf=NZDX7Ts9ZHHcnsu_0DNy3Ltwy0XZopBQ@mail.gmail.com>
References: <1480326472-5849-1-git-send-email-yegorslists@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1480326472-5849-1-git-send-email-yegorslists@googlemail.com>
Sender: netdev-owner@vger.kernel.org
To: netdev <netdev@vger.kernel.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Grygorii Strashko <grygorii.strashko@ti.com>, "N, Mugunthan V" <mugunthanvnm@ti.com>, David Miller <davem@davemloft.net>, Yegor Yefremov <yegorslists@googlemail.com>
List-Id: linux-omap@vger.kernel.org

On Mon, Nov 28, 2016 at 10:47 AM,  <yegorslists@googlemail.com> wrote:
> From: Yegor Yefremov <yegorslists@googlemail.com>
>
> This patch adds support for ethtool's '-r' command. Restarting
> N-WAY negotiation can be useful to activate newly changed EEE
> settings etc.
>
> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>

This patch applies on top of
http://marc.info/?l=linux-netdev&m=148032251729251&w=2

Yegor
