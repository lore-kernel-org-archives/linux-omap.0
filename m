From: Sakari Ailus <sakari.ailus@nokia.com>
Subject: Re: [PATCH] ARM: OMAP2: Camera: Add OMAP2 24xx camera driver.
Date: Fri, 02 Mar 2007 19:50:52 +0200
Message-ID: <45E863FC.3060807@nokia.com>
References: <45E5A489.2040108@nokia.com>	
	<11726783562347-git-send-email-sakari.ailus@nokia.com>
	<5d5443650702282326w79a4a4aexf0f33a804cd975c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <5d5443650702282326w79a4a4aexf0f33a804cd975c@mail.gmail.com>
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

Thanks for your comments. They indeed were useful and I'm planning to do 
roughly everything I'm not commenting.

ext Trilok Soni wrote:
> On 2/28/07, Sakari Ailus <sakari.ailus@nokia.com> wrote:
>> +
>> +/* This should be called by the sensor code whenever it's ready */
>> +int omap24xxcam_sensor_register(struct omap_camera *oc,
>> +                               struct omap_camera_sensor *os)
>> +{
>> +       struct omap24xxcam_device *cam = oc->priv;
>> +       int rval;
>> +
>> +       /* the device has not been initialised yet */
>> +       if (cam == NULL)
>> +               return -ENODEV;
>> +       if (os == NULL)
>> +               return -EINVAL;
>> +       if (cam->sensor != NULL)
>> +               return -EBUSY;
>> +
>> +       cam->sensor = os;
>> +       rval = omap24xxcam_device_enable(cam);
>> +
>> +       if (rval)
>> +               cam->sensor = NULL;
>> +       return rval;
>> +}
>> +
>> +EXPORT_SYMBOL(omap24xxcam_sensor_register);
> 
> What registration functionality is done above? I can see only checking
> against the sensor initialization and enabling it if not. Please use
> proper name.

"cam->sensor = os;".

This gives the sensor to the camera. So I think the name is justified.

>> diff --git a/drivers/media/video/omap/omap24xxcam.c 
>> b/drivers/media/video/omap/omap24xxcam.c
>> new file mode 100644
>> index 0000000..4f954ed
>> --- /dev/null
>> +++ b/drivers/media/video/omap/omap24xxcam.c
...
>> +
>> +static void omap24xxcam_clock_put(struct omap24xxcam_device *cam)
>> +{
>> +       if (cam->img.ick == NULL)
>> +               return;
> 
> What about img.fck check ?

omap24xxcam_clock_get always get()s both or neither. Thus there's no 
need to check both.

>> +
>> +        */
>> +       /* choose an arbitrary xclk frequency */
>> +       omap24xxcam_core_xclk_set(&cam->core, 12000000);
>> +
>> +       omap24xxcam_camera.priv = cam;
>> +
>> +       if ((rval = omap24xxcam_sensor_init(cam))) {
>> +               goto err;
>> +       }
> 
> No need of { }. Also please use proper goto labels as suggested earlier.

There's only one label in that function. omap24xxcam_device_disable will 
do whatever was left behind by failed omap24xxcam_device_enable. (Or at 
least that's the idea.)

>> +
>> +       /* install the interrupt service routine */
>> +       if (request_irq(INT_24XX_CAM_IRQ, omap24xxcam_isr, IRQF_DISABLED,
>> +                       CAM_NAME, cam)) {
>> +               printk(KERN_ERR CAM_NAME
>> +                      ": could not install interrupt service 
>> routine\n");
>> +               goto err;
>> +       }
>> +       cam->irq = INT_24XX_CAM_IRQ;
> 
> Please make proper use of platform_data and resources. irq should have
> come from device.c registration of platform resource. Please check my
> patches.
> 
> http://linux.omap.com/pipermail/linux-omap-open-source/2007-February/009064.html 

I fully agree with that.

Regards,

-- 
Sakari Ailus
sakari.ailus@nokia.com
