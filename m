From: Sakari Ailus <sakari.ailus@nokia.com>
Subject: Re: [PATCH] OMAP2 camera and TCM825x sensor drivers
Date: Wed, 07 Mar 2007 14:08:18 +0200
Message-ID: <45EEAB32.4090804@nokia.com>
References: <9C23CDD79DA20A479D4615857B2E2C475C9FE7@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <9C23CDD79DA20A479D4615857B2E2C475C9FE7@dlee13.ent.ti.com>
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
>>> do you have any kind of design doc or ppt that
>>> gives a brief overview of what the code is and the interface
> considered
> 
> Sakari, taking this back :) Sorry was kind of used to these for a while.

Good, as I didn't have any. ;)

>>> Do you mean "rotation" of the preview window ? See, preview in camera
>>> driver is just a add-on functionality _but_ not must. I would not use
>>> this auto preview functionality, instead captured stream will go to
>>> /dev/fb1 and then shown on the LCD/TV out and rotated based on the
>>> N800 sensor or app commands.
> 
> Trilok, this may be your use case but not true for all OMAP users :)
> Few take preview seriously; I have seen demands for a preview with
> rotation/mirroring/cropping/scaling :) Again it's as per demands.
> Why to send a data to app that is not getting stored? 

Is there a real life use case where even preview is really useful? Or 
necessary? (I'm asking because I can't figure anything immediately. 
Except maybe something like xawtv, but for a camera. :))

-- 
Sakari Ailus
sakari.ailus@nokia.com
