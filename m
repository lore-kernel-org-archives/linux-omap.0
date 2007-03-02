From: Sakari Ailus <sakari.ailus@nokia.com>
Subject: Re: [PATCH 1/4] [PATCH] ARM: OMAP: Update camera sensor interface
Date: Fri, 02 Mar 2007 18:37:19 +0200
Message-ID: <45E852BF.9020200@nokia.com>
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
To: ext Trilok Soni <soni.trilok@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

(Sorry for not replying, I just recently ordered this list.)

 > From: Trilok Soni <soni.trilok@gmail.com>
...
 > +#define PAR_MODE_NOBT8                       0
 > +#define PAR_MODE_NOBT10                      1
 > +#define PAR_MODE_NOBT12                      2
 > +#define PAR_MODE_BT8                 4
 > +#define PAR_MODE_BT10                        5
 > +
 > +#define SYNC_ACTIVE_HIGH             0
 > +#define SYNC_ACTIVE_LOW                      1

How about prefixing these with OMAP_SENSOR_ or something?

 > +#define V4L2_BUF_TYPE_STILL_CAPTURE  V4L2_BUF_TYPE_PRIVATE
 > +
 >  struct omap_camera_sensor {
 >       unsigned int version;
 >       char name[OMAP_SENSOR_NAME_LEN + 1];
 >
 > -     void *(*init)(struct v4l2_pix_format *);
 > +     int parallel_mode;  /* parallel I/F mode */
 > +     int hs_polarity;    /* horizontal sync polarity */
 > +     int vs_polarity;    /* vertical sync polarity */
 > +     int image_swap;     /* image swap or not */
 > +     int bt_correction;  /* BT correction enabled or not */

It's probably good to add here more information about the sensor. OV9640 
has differences in these compared to TCP825x? Or the Micron sensor?

 > +     /* init the sensor with the passed pix format. A none zero private
 > +        pointer must be returned on success. The same pointer is passed
 > +        back for all other functions. This gives a sensor driver the
 > +        chance to handle multiple sensor. */

Multiple sensor support is ability to handle different sensors?

What do you think of giving names to the function arguments?

 > +     void *(*init)(struct v4l2_pix_format *, struct v4l2_pix_format *);
...
 > +     /* These are only for those sensors that use a different sensor 
context
 > +        for still image capture. A simple sensor driver doesn't have to
 > +        implement them. */
 > +     int (*try_format_still_capture) (struct v4l2_pix_format *, void *);
 > +     int (*configure_still_capture) (struct v4l2_pix_format *, 
unsigned long,
 > +                                       struct v4l2_fract *, void *);
 > +     unsigned long (*calc_xclk_still_capture) (struct v4l2_pix_format *,
 > +             struct v4l2_fract *, void *);
 > +     int (*enter_still_capture) (int, void *);
 > +     int (*exit_still_capture) (void *);

Probably capturing still images and video is exclusive at least here? 
I've been thinking that omap24xxcam_poll mess...

-- 
Sakari Ailus
sakari.ailus@nokia.com
