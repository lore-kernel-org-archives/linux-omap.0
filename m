From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH] extcon: palmas: Don't spam console
Date: Wed, 25 Jan 2017 09:22:00 +0900
Message-ID: <5887EFA8.3000405@samsung.com>
References: <CGME20170124145418epcas1p152aa6de67df25eebc4ec841aa856c9b5@epcas1p1.samsung.com>
 <1485269647-552-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1485269647-552-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: myungjoo.ham@samsung.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Roger,

On 2017년 01월 24일 23:54, Roger Quadros wrote:
> User is not interested in USB cable events appearing on the
> console. Use dev_dbg() instead of dev_info() for these events.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  drivers/extcon/extcon-palmas.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

Applied it. Thanks.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
