From: "Trilok Soni" <soni.trilok@gmail.com>
Subject: Re: [PATCH 2/2] ARM: OMAP2: Camera: Improve ov9640 code on
	board-h4.c
Date: Thu, 22 Nov 2007 14:40:33 +0530
Message-ID: <5d5443650711220110o5281e042x4db6d3901264848e@mail.gmail.com>
References: <1195663431-20390-1-git-send-email-edubezval@gmail.com>
	<1195663431-20390-2-git-send-email-edubezval@gmail.com>
	<1195663431-20390-3-git-send-email-edubezval@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <1195663431-20390-3-git-send-email-edubezval@gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Eduardo Valentin <eduardo.valentin@indt.org.br>, Sakari Ailus <sakari.ailus@nokia.com>, linux-omap@vger.kernel.org, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Eduardo,

On Nov 21, 2007 10:13 PM, Eduardo Valentin <edubezval@gmail.com> wrote:
> From: Eduardo Valentin <eduardo.valentin@indt.org.br>
>
> - Removes unnecessary structures and functions when config OV9640
> is not selected.
> - Reduces powerset code for ov9640.
>
> Signed-off-by: Eduardo Valentin <eduardo.valentin@indt.org.br>
> ---

Thanx for the changes. Looks good to me. We have to make changes related
to gpio expander apis if gpiolib goes upstrem by David Brownell.

Acked-by: Trilok Soni <soni.trilok@gmail.com>

-- 
--Trilok Soni
