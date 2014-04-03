From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] clk: Add driver for Palmas clk32kg and clk32kgaudio clocks
Date: Thu, 3 Apr 2014 08:49:38 -0500
Message-ID: <533D66F2.7050600@ti.com>
References: <1396522348-31989-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1396522348-31989-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, mturquette@linaro.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, ldewangan@nvidia.com, linux-doc@vger.kernel.org, grant.likely@linaro.org
List-Id: linux-omap@vger.kernel.org

On 04/03/2014 05:52 AM, Peter Ujfalusi wrote:
[...]
>  .../devicetree/bindings/clock/clk-palmas.txt       |  35 +++
>  drivers/clk/Kconfig                                |   7 +
>  drivers/clk/Makefile                               |   1 +
>  drivers/clk/clk-palmas.c                           | 307 +++++++++++++++++++++
>  include/dt-bindings/mfd/palmas.h                   |  18 ++
>  5 files changed, 368 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/clk-palmas.txt
>  create mode 100644 drivers/clk/clk-palmas.c
>  create mode 100644 include/dt-bindings/mfd/palmas.h


Only complaint i have is based on :
http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=2a9330010bea5982a5c6593824bc036bf62d67b7

you may want to split the new binding off to a separate patch.
Otherwise, personally, I think it is an good evolution, thanks for
doing it.


-- 
Regards,
Nishanth Menon
