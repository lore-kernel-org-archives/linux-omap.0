From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: libcurl for omap arm linux
Date: Sun, 03 Dec 2006 17:42:58 +0100
Message-ID: <4572FE92.7060405@gmail.com>
References: <829041.25922.qm@web34504.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <829041.25922.qm@web34504.mail.mud.yahoo.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: binil antony <binsoft007@yahoo.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

binil antony wrote:
> I took the pre built lib from the link that you
> specified. But I get the following linker errors when
> I link the libcurl.a with my sample appl.

You really should send questions publically to the list.

> /usr/local/wma/mvl-tool/mvl-tools-229/montavista/cee/devkit/arm/v5t_le/bin/../lib/gcc-lib/armv5tl-hardhat-linux/3.3.1/../../../../armv5tl-hardhat-linux/bin/ld:
> ERROR: /home/binil/lib/usr/lib//libcurl.a(easy.o) uses
> hardware FP, whereas ./sample.out uses software FP

Your sample.out is compiled to use software floating point, 
whereas the library is compiled to use hardware floating 
point. I'm not a toolchain expert, but IMHO hardware 
floating point is correct here (because ARM kernel emulates 
floating point). So you should compile sample.out with 
option for hardware floating point as well.

Having compiler version (armv5tl-hardhat-linux-gcc -v (?)) 
and compile & link options you used for sample.out may be 
helpful here.

> /usr/local/wma/mvl-tool/mvl-tools-229/montavista/cee/devkit/arm/v5t_le/bin/../lib/gcc-lib/armv5tl-hardhat-linux/3.3.1/../../../../armv5tl-hardhat-linux/bin/ld:
> Warning: /home/binil/lib/usr/lib//libcurl.a(easy.o)
> does not support interworking, whereas ./sample.out
> does
> No such file or directory: failed to merge target
> specific data of file
> /home/binil/lib/usr/lib//libcurl.a(easy.o)

You compiled sample.out with interworking enabled, which 
isn't supported by the library. Again, having compile & link 
options may clarify this.

Conclusion is that the compile & link options you used for 
sample.out are incompatible which those the library is build 
with.

Dirk
