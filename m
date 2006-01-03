From: janiszo@poczta.onet.pl
Subject: Re: Re: USB problem in 2.6.14.5
Date: Tue, 03 Jan 2006 14:10:18 +0100
Message-ID: <20060103131020Z1184073-30416+231@kps8.test.onet.pl>
References: <43BA5753.5050704@uma.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <43BA5753.5050704@uma.es>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Jose Manuel Cano Garcia <jcgarcia@uma.es>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Yes, disabling RESET_UNUSED_CLOCK made USB working again.
Thanks. I missed these archive posts.

Jack

> Jose Manuel Cano Garcia <jcgarcia@uma.es> wrote:
>Hi,
>
>If you are using a OSK5912 board, please read the thread "OSK5912 USB 
>Port Problem" in this mailing list (November 2005) (I am not sure if the 
>problem also exists for other boards). An additional patch is needed for 
>kernel from 2.6.12 to 2.6.15 to get USB host working. Alternatively, you 
>can disable the RESET_UNUSED_CLOCK feature.
>
>This is the patch:
>
>http://linux.omap.com/pipermail/linux-omap-open-source/2005-August/004818.html 
>
>
>See also the following mail on this list:
>
>http://linux.omap.com/pipermail/linux-omap-open-source/2005-December/006030.html
>
>Best regards,
>
>Jose
>
>janiszo@poczta.onet.pl wrote:
>
>>Hi,
>>Are there any changes in kernel 2.6.14 against 2.6.11 with USB support? I compiled new kernel with the same options as in the old one and system cannot see USB devices now. There is no /proc/bus/usb folder at all, while during startup mesaages about usbco
>>re/ohci/mass storage registering appear.
>>I\'m, using kernel 2.6.14.5 with patch-2.6.14-omap2.
>>
>>Jack 
>>_______________________________________________
>>Linux-omap-open-source mailing list
>>Linux-omap-open-source@linux.omap.com
>>http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>>
>>.
>>
>>  
>>
>
