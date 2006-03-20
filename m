From: Komal Shah <komal_shah802003@yahoo.com>
Subject: Re: [PATCH] Re: v4l2 camera test app
Date: Mon, 20 Mar 2006 12:16:36 -0800 (PST)
Message-ID: <20060320201636.49261.qmail@web32908.mail.mud.yahoo.com>
References: <441ECE1F.9000709@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <441ECE1F.9000709@indt.org.br>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: David Cohen <david.cohen@indt.org.br>, ext Ola Helm <ola.hel@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

--- David Cohen <david.cohen@indt.org.br> wrote:

> Hi,
> 
> I am sending a new version of the camera driver for omap2420. Unlike
> the
> last patch I sent, I am not using those functions from dispc and vout
> that were not applied yet.
> The sensor module should be configured to BT8. The configurations for
> NOBT are in the code, but commented on omap24xxcam_sensor_cc_ctrl
> function. It can be changed if necessary.
> 
> +
> +#include "omap24xxcam.h"
> +
> +#define CAMERA_OV9640
> +#ifdef CAMERA_OV9640
> +#include "ov9640.h"
> +#endif

You may not need to include this. 


> +static void omap24xxcam_sensor_cc_ctrl(struct omap24xxcam_device
> *cam)
> +{
> +	struct v4l2_pix_format *pix = &cam->pix;
> +
> +	DBG;
> +
> +	cam->cc_ctrl =		/*CC_CTRL_NOBT_SYNCHRO | CC_CTRL_NOBT_VS_POL */
> +	    CC_CTRL_BT_CORRECT | CC_CTRL_PAR_MODE_BT8;

As I believe this should come from sensor, I think Jian added this in
the new sensor interface. 


> +		if (!in_atomic()) {
> +			set_current_state(TASK_INTERRUPTIBLE);
> +			schedule_timeout(1);

We can use the new api available which combines this two functions.

> +		CAMDMA_CSDP_WRITE_MODE_POSTED 
> +	      | CAMDMA_CSDP_DST_BURST_EN_64
> +	      | CAMDMA_CSDP_DST_PACKED
> +	      | CAMDMA_CSDP_SRC_BURST_EN_64

Why changing from 16 to 64? vga? 

> +
> +	cam = kmalloc(sizeof(struct omap24xxcam_device), GFP_KERNEL);
> +	if (!cam) {
> +		printk(KERN_ERR CAM_NAME ": could not allocate memory\n");
> +		goto init_error;
> +	}
> +	memset(cam, 0, sizeof(struct omap24xxcam_device));

I like kzalloc.

---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
