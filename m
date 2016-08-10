From: Mugunthan V N <mugunthanvnm@ti.com>
Subject: Re: [PATCH v3 09/13] net: ethernet: ti: cpsw: move cpdma resources to
 cpsw_common
Date: Wed, 10 Aug 2016 21:13:46 +0530
Message-ID: <8fd63af8-f844-4ef5-ddda-b69af413c463@ti.com>
References: <1470784964-26440-1-git-send-email-ivan.khoronzhuk@linaro.org>
 <1470784964-26440-10-git-send-email-ivan.khoronzhuk@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1470784964-26440-10-git-send-email-ivan.khoronzhuk@linaro.org>
Sender: netdev-owner@vger.kernel.org
To: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, netdev@vger.kernel.org, grygorii.strashko@ti.com
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, dlide@ti.com
List-Id: linux-omap@vger.kernel.org

On Wednesday 10 August 2016 04:52 AM, Ivan Khoronzhuk wrote:
> Every net device private struct holds links to shared cpdma resources.
> No need to save and every time synchronize these resources per net dev.
> So, move it to common driver struct.
> 
> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>

Reviewed-by: Mugunthan V N <mugunthanvnm@ti.com>

Regards
Mugunthan V N
