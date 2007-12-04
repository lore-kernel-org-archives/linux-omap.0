From: Felipe Balbi <ext-felipe.lima@nokia.com>
Subject: Re: MEASURING CURRENT DRAWN BY OMAP5912
Date: Tue, 4 Dec 2007 08:19:44 -0400
Message-ID: <20071204121944.GA6636@1BRL00624.americas.nokia.com>
References: <255390.68653.qm@web7601.mail.in.yahoo.com>
Reply-To: ext-felipe.lima@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <255390.68653.qm@web7601.mail.in.yahoo.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "ext Azhar Mr." <shaik.azharuddin@yahoo.co.in>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Tue, Dec 04, 2007 at 07:44:29AM +0000, ext Azhar Mr. wrote:
> Hello Everyone,
>    
>           I want to measure the amount of current drawn by the OMAP 5912 board.
>   Please somebody help me in providing the procedure to measure the current.
>    
>          I also want to measure the current when external devices like COMPACT FLASH, USB, WEBCAM, KEYPAD, GPS are connected to the OMAP5912.

Powering it up with an external controllable power supply is the best
choice.

I mean those where you can set the voltage to source. Use on of those
and you can read the current being drawn.


-- 
Best Regards,

Felipe Balbi
felipe.lima@indt.org.br
+55 92 2126-1003

INdT - OSMRC - Manaus
Core Team
