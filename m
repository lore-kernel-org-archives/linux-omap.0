From: Dirk Behme <dirk.behme@de.bosch.com>
Subject: Re: [PATCH] Convert touchscreen to input_allocate_device
Date: Mon, 16 Jan 2006 19:15:48 +0100
Message-ID: <43CBE2D4.4000003@de.bosch.com>
References: <890E52023811004CB455C1B7C433BA101A8B26@dino.eu.tieto.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <890E52023811004CB455C1B7C433BA101A8B26@dino.eu.tieto.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Mikko.Soikkala@Tietoenator.com
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Mikko.Soikkala@Tietoenator.com wrote:
> Hi
> 
> Shouldn't there be a check after input_allocate_device() if the
> allocation fails? At least other touchscreen drivers seem to return
> -ENOMEM in this case.

Sounds good to me. Can you send a patch?

Thanks

Dirk
