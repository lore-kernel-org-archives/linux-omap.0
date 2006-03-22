From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: Problems building DSP gateway on 2.6.15
Date: Wed, 22 Mar 2006 17:19:11 +0100
Message-ID: <442178FF.7060803@gmail.com>
References: <008101c64dcb$7d1cb110$642aa8c0@BUFFY>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <008101c64dcb$7d1cb110$642aa8c0@BUFFY>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Richard Copeman <richard.copeman@lauterbach.co.uk>, toshihiro.kobayashi@nokia.com, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Richard Copeman wrote:
> Toshihiro san,
> 
> Thanks for the pointer.
> There is no OMAP DSP Gateway message displayed during my startup.
> I do not do "make uImage". I use a JTAG debugger to download vmlinux
> directly to RAM. What does "make uImage" do for me?

If you use JTAG debugger for download you don't need 'make 
uImage'. You only need this if you use bootloader U-Boot to 
download and start the image.

Dirk
