From: Komal Shah <komal_shah802003@yahoo.com>
Subject: RE: [PATCH] camera: c99 style structure
Date: Thu, 24 Nov 2005 02:47:27 -0800 (PST)
Message-ID: <20051124104727.61283.qmail@web32902.mail.mud.yahoo.com>
References: <304D2A85A9643F4A991BDDF8D297BBA60187D82F@dlee05.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <304D2A85A9643F4A991BDDF8D297BBA60187D82F@dlee05.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Zhang, Jian" <jzhang@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

--- "Zhang, Jian" <jzhang@ti.com> wrote:

> " But I was thinking to create
> files under drivers/media/video/omap directory like
> sensor_power_h2/h4/<custom board name> to export powerup/down
> function
> related to sensors based on board interface."
> 
> Yes, this is what I meant.

Thanx. I will submit the patch for that then.

> 
> Porting OMAP2 driver to camera_core is not straightforward. We are
> developing a new sensor driver for TI/Micron camera which has sensor
> context A and B. This will require the change to omap24xxcam.c. If
> you
> want to spend time in unifying OMAP1 and OMAP2 camera drivers, I
> suggest
> you wait until my change to omap24xxcam.c is done.
> 

Ok, I can wait. As I said earlier, I am having custom made Micron
MT9M011 camera module which can interface with H4 EVM and Blackfin. I
have already tested I2C communication interface with H4 and with
Blackfin I was able to capture with default settings. 

Which Micron sensor you are using? I know about context A and B stuff
for Micron.

Meanwhile I can add video out interface with OMAP2 instead. I have put
Imre and Juha in the CC, as Imre already added very good code for FB
and might have some inputs on utilizing command dispc related functions
in vid out framework.

---Komal Shah
http://komalshah.blogspot.com/


		
__________________________________ 
Start your day with Yahoo! - Make it your home page! 
http://www.yahoo.com/r/hs
