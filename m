From: Sakari Ailus <sakari.ailus@nokia.com>
Subject: [RFC] OMAP 2 camera driver (and TCM825x sensor driver)
Date: Thu, 22 Mar 2007 19:05:09 +0200
Message-ID: <4602B745.7000006@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
Cc: Eduardo Bezerra Valentin <eduardo.valentin@indt.org.br>, "Biris,  Ilias" <ilias.biris@indt.org.br>
List-Id: linux-omap@vger.kernel.org

Hi,

I'm again about to send a new version of the OMAP 2 camera and TCM825x 
sensor drivers. There's very little changes in the TCM825x driver, so 
it's included mostly just as a reference.


What essential has changed:

- omap24xxcam_core, omap24xxcam_img and omap24xxcam_capture structures 
are gone.

- omap24xxcam_core_enable as a callback is gone. Core is started 
independently of the DMA transfer.

- Core is disabled until there is a scatter-gather buffer that actually 
is able to receive data.

- Core is disabled by resetting it. This seems to prevent majority of 
interface errors which I've been noticing on N800.

- Reset handling has been modified. Reset takes place now only when core 
is disabled and no DMA transfers are going on.

- The DMA subsystem now looks more like what it originally was.

- Xclk handling has been simplified.

- read() is gone. This simplifies locking a lot. Does anyone want 
read(), btw.? Its removal simplifies things somewhat. And it wasn't 
working anymore anyway...

- mmapped buffers are now freed (more) correctly. Calling buf_setup for 
released buffers caused an oops.

- N800-specific hardware-dependent code should be about there.

- General cleanups plus other stuff I don't remember now.


What I still don't like:

- How omap24xxcam-vbq.c and omap24xxcam-dma.c look like.

- omap24xxcam-sensor.c is a place for wrappers to sensor interface. 
Similar things are performed in omap24xxcam.c as well and the wrappers 
do little good. Some refactoring is required, I guess.

- All the header files are somewhat messy.

- Bad things may happen now if the sensor driver is rmmod'ed while the 
camera is in use. The sensor driver should probably wait. Maybe other 
problems related to camera driver unloading as well. But this is not 
critical, IMO.

- mmap code. Part of this will go away with MMU support.

- Way too many globals.


I also have some questions.

How the sensor driver really should know about the camera? Now the 
camera interface structure is a global variable (omap24xxcam in 
omap24xxcam.c) which the sensor driver will get as a part of its 
machine-specific configuration.

And how do you like camera -> sensor interface should look like? Opinions?


Eduardo and Ilias have expressed some interest towards the camera driver 
so I'm Cc:ing to them as well.

Trilok: I haven't forgotten your omap_camera_sensor interface changes 
for the OV sensor regarding sync polarity etc. But I can't say anything 
about still capture at the moment.

Comments, suggestions, opinions, code reviews and patches are welcome. :-)

Best regards,

-- 
Sakari Ailus
sakari.ailus@nokia.com
