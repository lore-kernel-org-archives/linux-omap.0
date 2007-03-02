From: Sakari Ailus <sakari.ailus@nokia.com>
Subject: Re: [PATCH] OMAP2 camera and TCM825x sensor drivers
Date: Fri, 02 Mar 2007 11:42:35 +0200
Message-ID: <45E7F18B.50005@nokia.com>
References: <9C23CDD79DA20A479D4615857B2E2C475C9521@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <9C23CDD79DA20A479D4615857B2E2C475C9521@dlee13.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "ext Syed Mohammed, Khasim" <x0khasim@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

ext Syed Mohammed, Khasim wrote:
> If some patches are for review please mark them as "RFC". "Patch" is
> when it has to go into tree - Some one can correct me if I am wrong.

Alright, I'll do that next time.

> Thanks for the code, do you have any kind of design doc or ppt that
> gives a brief overview of what the code is and the interface considered
> etc. Its bit hard to go directly to code :(

I'm afraid I don't have any.

The primary goal for me at the moment regarding these drivers is to 
clean them up and integrated them to Tony's git tree. I think supporting 
all the features at this point is somewhat secondary unless they are 
really needed.

> The second issue is merging TI's camera code with this. I can post our
> design considerations for camera. We can see how to integrate TIs sensor
> and additional functionality provided by TI's camera code (like
> rotation, scatter gather dma, multiple sensors handling etc).

Add-on features will probably have to wait till I get the driver into 
better shape.

-- 
Sakari Ailus
sakari.ailus@nokia.com
