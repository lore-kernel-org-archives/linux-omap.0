From: Komal Shah <komal_shah802003@yahoo.com>
Subject: Re: Building DSP code for 2420 standalone
Date: Wed, 21 Dec 2005 06:25:24 -0800 (PST)
Message-ID: <20051221142524.7725.qmail@web32911.mail.mud.yahoo.com>
References: <002701c60638$bb957fb0$642aa8c0@BUFFY>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <002701c60638$bb957fb0$642aa8c0@BUFFY>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Richard Copeman <richard.copeman@lauterbach.co.uk>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

--- Richard Copeman <richard.copeman@lauterbach.co.uk> wrote:

> Hi,
> 
>  
> 
> Can somebody point me at an FAQ or how to that will start me off
> building a
> standalone DSP application for the DSP core on the 2420?
> 
> I want to generate the .out image but without linking in the LINUX
> dsp
> gateway driver code.
> 
> Do I need a 2420 BSP equivalent to get something running?
> 
> I'm sure I will have many more questions before I'm finished ;-)

As of now, there is no open dspgateway which can handle IVA and the
C55x for 24xx. Toshiharo-san was working on porting open dspgateway for
24xx C55x.

But you can ask your TI FAE to get better idea on different options :)

---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
