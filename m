From: "Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 0/8] musb: Add structure 'musb_hdrc_board_data'
Date: Thu, 19 Nov 2009 11:21:39 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394043702BB7A@dbde02.ent.ti.com>
References: <1258470596-24321-1-git-send-email-ajay.gupta@ti.com>
	<4B040293.1020501@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <4B040293.1020501-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Sergei Shtylyov <sshtylyov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Cc: "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org" <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Gadiyar, Anand" <gadiyar-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,
> -----Original Message-----
> From: Sergei Shtylyov [mailto:sshtylyov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org] 
> Sent: Wednesday, November 18, 2009 7:50 PM
> To: Gupta, Ajay Kumar
> Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; 
> davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org; 
> cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org; felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org; 
> linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Gadiyar, Anand
> Subject: Re: [PATCH 0/8] musb: Add structure 'musb_hdrc_board_data'
> 
> Hello.
> 
> Ajay Kumar Gupta wrote:
> 
> > This patch set adds a new structure 'musb_hdrc_board_data' 
> to get all 
> > board specific data from board files.
> 
> > It is actually done to accomodate ULPI_VBUSCONTROL programming 
> > required for OMAP3EVM Rev >=E which uses external Vbus 
> supply to support 500mA.
> 
>     It's not clear why it was necessary to create yet another 
> structure. You could your new field to 'struct 
> musb_hdrc_platfrom_data'...

This a actually a simpler approach and would avoid changing Davinci/BLackFin
Specific files.

Felipe/Anand,
Is it ok to add 'extvbus' in 'musb_hdrc_platform_data' and pass this data
from all OMAP board files. 

Anyways we do have 'musb_config' which has all platform sepecific information.

-Ajay
> 
> > Regards,
> > Ajay
> 
> WBR, Sergei
> 
> 
