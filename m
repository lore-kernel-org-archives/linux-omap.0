From: Matt Callow <mc-lists@tesco.net>
Subject: Possible error in omap16xxcam_set_xclk?
Date: Tue, 13 Jun 2006 16:07:40 +0100
Message-ID: <448ED4BC.1010804@tesco.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

  Hi,

I've been looking at omap/omap16xxcam.c (with a view to creating an 
omap1510 equivalent) and have noticed the following:


        int divisor = 1;
        divisor = data->ocp_clk/xclk;
        if ( divisor * xclk < data->ocp_clk)
                ++divisor;

        switch (divisor) {
                case 1:
                case 2:
                        xclk_val = FOSCMOD_TC2_CK2;
                        break;
                case 3:
                        xclk_val = FOSCMOD_TC2_CK3;
                        break;
                case 4:
                case 5:
                case 6:
                case 7:
                        xclk_val = FOSCMOD_TC2_CK4;
                        break;
...

Now, by my reckoning, divisor can only be 1 or 2 when it reaches the 
case statement. So, should the preceding if statement actually be:

        while ( divisor * xclk < data->ocp_clk)
                ++divisor;

?

regards

Matt Callow
