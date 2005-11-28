From: Komal Shah <komal_shah802003@yahoo.com>
Subject: Re: [PATCH] Re: Convert input devices to input_allocate_device
Date: Mon, 28 Nov 2005 02:03:13 -0800 (PST)
Message-ID: <20051128100313.68791.qmail@web32907.mail.mud.yahoo.com>
References: <438AD3D9.1090002@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <438AD3D9.1090002@de.bosch.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Dirk Behme <dirk.behme@de.bosch.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

--- Dirk Behme <dirk.behme@de.bosch.com> wrote:

> ARM: OMAP: Convert input devices to input_allocate_device:
> 
> input: device omap-keypad is statically allocated, will not register
> Please convert to input_allocate_device() or contact
> dtor_core@ameritech.net
> 
> input: device omap_ts is statically allocated, will not register
> Please convert to input_allocate_device() or contact
> dtor_core@ameritech.net
> 
> ARM: OMAP: Check in omap_ts_handler() if timer is still running.
> Delete
> it if neccessary. Else we will get Oops "kernel BUG at
> include/linux/timer.h:83!"

If Tony, applies my patch of keypad driver model first then your patch
will break.

---Komal Shah
http://komalshah.blogspot.com/


	
		
__________________________________ 
Yahoo! Mail - PC Magazine Editors' Choice 2005 
http://mail.yahoo.com
