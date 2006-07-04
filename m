From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: [PATCH 1/4] Input: ads7846: detect pen up from IRQ state
Date: Tue, 04 Jul 2006 17:10:04 +0200
Message-ID: <44AA84CC.5020808@gmail.com>
References: <20060703182931.GA29921@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <20060703182931.GA29921@localdomain>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: imre.deak@solidboot.com
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Imre,

imre.deak@solidboot.com wrote:
> We can't depend on the pressure value to determine when the pen was
> lifted, so use the IRQ line state instead.

Today, Tony pushed the "input: ads7846: can't disable 
filtering"

http://linux.omap.com/pipermail/linux-omap-open-source/2006-June/007358.html

fix from beginning of June.

Yesterday, you posted a new patchset "[PATCH 1/1-4] Input: 
ads7846:". As I understand it, this recent patch set is the 
clean version of ads7846 and is a replacement for the old 
workaround now pushed by Tony? Or is it an add on?

Wasn't able to test this patchset, somewhat impossible 
without framebuffer ;)

Best regards

Dirk
