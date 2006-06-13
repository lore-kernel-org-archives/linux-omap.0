From: Matt Callow <mc-lists@tesco.net>
Subject: Re: Possible error in omap16xxcam_set_xclk?
Date: Tue, 13 Jun 2006 21:52:25 +0100
Message-ID: <448F2589.6090304@tesco.net>
References: <448ED4BC.1010804@tesco.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <448ED4BC.1010804@tesco.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Matt Callow wrote:

>  Hi,
>
> I've been looking at omap/omap16xxcam.c (with a view to creating an
> omap1510 equivalent) and have noticed the following:
>
>
>        int divisor = 1;
>        divisor = data->ocp_clk/xclk;
>        if ( divisor * xclk < data->ocp_clk)
>                ++divisor;
>
>        switch (divisor) {
>                case 1:
>                case 2:
>                        xclk_val = FOSCMOD_TC2_CK2;
>                        break;
>                case 3:
>                        xclk_val = FOSCMOD_TC2_CK3;
>                        break;
>                case 4:
>                case 5:
>                case 6:
>                case 7:
>                        xclk_val = FOSCMOD_TC2_CK4;
>                        break;
> ...
>
> Now, by my reckoning, divisor can only be 1 or 2 when it reaches the
> case statement. So, should the preceding if statement actually be:
>
>        while ( divisor * xclk < data->ocp_clk)
>                ++divisor;
>
> ?
>
>
No!
Answered my own question! I should have looked more carefully at the
code :-)

Matt
