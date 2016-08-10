From: Mugunthan V N <mugunthanvnm@ti.com>
Subject: Re: [PATCH v3 08/13] net: ethernet: ti: cpsw: move links on h/w
 registers to cpsw_common
Date: Wed, 10 Aug 2016 21:12:59 +0530
Message-ID: <dcf9979c-81f0-ac20-b1fa-eb2336775be3@ti.com>
References: <1470784964-26440-1-git-send-email-ivan.khoronzhuk@linaro.org>
 <1470784964-26440-9-git-send-email-ivan.khoronzhuk@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1470784964-26440-9-git-send-email-ivan.khoronzhuk@linaro.org>
Sender: netdev-owner@vger.kernel.org
To: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, netdev@vger.kernel.org, grygorii.strashko@ti.com
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, dlide@ti.com
List-Id: linux-omap@vger.kernel.org

On Wednesday 10 August 2016 04:52 AM, Ivan Khoronzhuk wrote:
> The pointers on h/w registers are common for every cpsw_private
> instance, so no need to hold them for every ndev.
> 
> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>


Reviewed-by: Mugunthan V N <mugunthanvnm@ti.com>

Regards
Mugunthan V N
