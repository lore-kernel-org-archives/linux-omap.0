From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/1] ARM: OMAP: Fix Siemens SX1 building failure
Date: Fri, 30 Nov 2007 16:08:14 -0800
Message-ID: <20071201000813.GN7498@atomide.com>
References: <474ED73E.70104@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <474ED73E.70104@indt.org.br>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Carlos Aguiar <carlos.aguiar@indt.org.br>
Cc: omap-linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

* Carlos Aguiar <carlos.aguiar@indt.org.br> [071129 07:16]:
> From: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>
> 
> This patch redefines CN_IDX_SX1SND and CN_VAL_SX1SND macros at include/linux/connector.h.
> It is based on Komal Shah' earlier patch.
> 
> Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>
> ---
>  include/linux/connector.h |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/include/linux/connector.h b/include/linux/connector.h
> index 13fc454..29ddd3f 100644
> --- a/include/linux/connector.h
> +++ b/include/linux/connector.h
> @@ -36,6 +36,8 @@
>  #define CN_VAL_CIFS                     0x1
>  #define CN_W1_IDX			0x3	/* w1 communication */
>  #define CN_W1_VAL			0x1
> +#define CN_IDX_SX1SND			0x4
> +#define CN_VAL_SX1SND			0x1
>  #define CN_IDX_V86D			0x4
>  #define CN_VAL_V86D_UVESAFB		0x1
>  

Pushing today.

Tony
