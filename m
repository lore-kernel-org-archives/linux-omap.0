From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: USBNET not in OSK5912
Date: Sun, 08 Oct 2006 20:14:30 +0200
Message-ID: <45294006.40803@gmail.com>
References: <000201c6ead0$e8decad0$6401a8c0@jjcar607>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <000201c6ead0$e8decad0$6401a8c0@jjcar607>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: John Carlos <Jcarlos201@comcast.net>
Cc: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

John Carlos wrote:
>   I was wondering why CONFIG_USB_USBNET is not in the OSK5912 default
> config yet it is other omap implementations.  Is there some sort of
> hardware limitation on the OSK that is not in the others ie: Innovator
> and so on?

As I know there is no hardware limitation on the OSK 
regarding this. IMHO nobody enabled it because of the nice 
normal onboard network. Do you tried to enable it?

Dirk
