From: Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [balbi-usb:testing/next 64/67] phy-generic.c:undefined reference to `usb_gadget_vbus_connect'
Date: Tue, 07 Jun 2016 13:22:37 +0300
Message-ID: <87inxlb8nm.fsf@linux.intel.com>
References: <201606062026.EQTlXIDR%fengguang.wu@intel.com> <87bn3ecwbz.fsf@linux.intel.com> <878tyicva6.fsf@linux.intel.com> <20160607015405.GB17095@shlinux2> <87wpm1basy.fsf@linux.intel.com> <20160607095008.GC17095@shlinux2>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160607095008.GC17095@shlinux2>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Chen <hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: kbuild test robot <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Peter Chen <Peter.Chen-3arQi8VN3Tc@public.gmane.org>, John Youn <johnyoun-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Mathias Nyman <mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, kbuild-all-JC7UmRfGjtg@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Peter Chen <hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> writes:
>> >> > kbuild test robot <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> writes:
>> >> >> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.=
git testing/next
>> >> >> head:   89fe2b5ab11cdf6a67d4492d893e70e330aa7060
>> >> >> commit: 231b31ca34485552fe27e67dc6d30d06079c7648 [64/67] usb: gadg=
et: move gadget API functions to udc-core
>> >> >> config: x86_64-randconfig-s1-06061834 (attached as .config)
>> >> >> compiler: gcc-6 (Debian 6.1.1-1) 6.1.1 20160430
>> >> >> reproduce:
>> >> >>         git checkout 231b31ca34485552fe27e67dc6d30d06079c7648
>> >> >>         # save the attached .config to linux build tree
>> >> >>         make ARCH=3Dx86_64=20
>> >> >>
>> >> >> All errors (new ones prefixed by >>):
>> >> >>
>> >> >>    drivers/built-in.o: In function `nop_set_peripheral':
>> >> >>>> phy-generic.c:(.text+0x14423f): undefined reference to `usb_gadg=
et_vbus_connect'
>> >> >>    drivers/built-in.o: In function `nop_gpio_vbus_thread':
>> >> >>>> phy-generic.c:(.text+0x144742): undefined reference to `usb_gadg=
et_vbus_disconnect'
>> >> >
>> >> > oh yeah, I have to fix this. I'll do it now.
>> >>=20
>> >> In order to fix this, I'll have to add something like below:
>> >>=20
>> >> diff --git a/drivers/usb/chipidea/Kconfig b/drivers/usb/chipidea/Kcon=
fig
>> >> index 3644a3500b70..bd67e4ac4b61 100644
>> >> --- a/drivers/usb/chipidea/Kconfig
>> >> +++ b/drivers/usb/chipidea/Kconfig
>> >> @@ -19,6 +19,7 @@ config USB_CHIPIDEA_OF
>> >>  config USB_CHIPIDEA_PCI
>> >>  	tristate
>> >>  	depends on PCI
>> >> +	depends on USB_GADGET=3Dy || USB_GADGET=3DNOP_USB_XCEIV
>> >>  	depends on NOP_USB_XCEIV
>> >>  	default USB_CHIPIDEA
>> >
>> > Hi Felipe,
>> >
>> > It causes any drivers which use symbols from gadget.h needs to build
>> > USB_GADGET even it only wants to be host function. Any significant
>> > benefits after moving it to udc-core.c?
>>=20
>> why is a host-only function calling into the gadget API?
>>=20
>
> Well, Just like this case, the chipidea driver can be configured host
> mode only, but it still uses generic phy.

then we should allow for PHYs to not depend on the Gadget API, right?

> Besides, we have some common code which handles vbus status, this code
> will be built even at host-only mode, but will not be called since the
> runtime condition is not satisfied, eg, dr_mode, device role at
> register.

driver shouldn't depend on the gadget API if it's not built with Gadget
support. Look at dwc3 for instance. All gadget API-related code is
stashed in ep0.c and gadget.c, but those only get built if the driver
was built with gadget support:

Kconfig
=3D=3D=3D=3D=3D=3D=3D

8<------------------------------------------------------------------------

choice
	bool "DWC3 Mode Selection"
	default USB_DWC3_DUAL_ROLE if (USB && USB_GADGET)
	default USB_DWC3_HOST if (USB && !USB_GADGET)
	default USB_DWC3_GADGET if (!USB && USB_GADGET)

config USB_DWC3_HOST
	bool "Host only mode"
	depends on USB=3Dy || USB=3DUSB_DWC3
	help
	  Select this when you want to use DWC3 in host mode only,
	  thereby the gadget feature will be regressed.

config USB_DWC3_GADGET
	bool "Gadget only mode"
	depends on USB_GADGET=3Dy || USB_GADGET=3DUSB_DWC3
	help
	  Select this when you want to use DWC3 in gadget mode only,
	  thereby the host feature will be regressed.

config USB_DWC3_DUAL_ROLE
	bool "Dual Role mode"
	depends on ((USB=3Dy || USB=3DUSB_DWC3) && (USB_GADGET=3Dy || USB_GADGET=
=3DUSB_DWC3))
	help
	  This is the default mode of working of DWC3 controller where
	  both host and gadget features are enabled.

endchoice

8<------------------------------------------------------------------------


Makefile
=3D=3D=3D=3D=3D=3D=3D=3D

8<------------------------------------------------------------------------

ifneq ($(filter y,$(CONFIG_USB_DWC3_GADGET) $(CONFIG_USB_DWC3_DUAL_ROLE)),)
	dwc3-y				+=3D gadget.o ep0.o
endif

8<------------------------------------------------------------------------

In any case, here's a better version of this patch:

commit 9062bc60311d0a4bbe84e2aa3ec7c2cba06356e4
Author: Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Date:   Tue May 31 13:07:47 2016 +0300

    usb: gadget: move gadget API functions to udc-core
=20=20=20=20
    instead of defining all functions as static inlines,
    let's move them to udc-core and export them with
    EXPORT_SYMBOL_GPL, that way we can make sure that
    only GPL drivers will use them.
=20=20=20=20
    As a side effect, it'll be nicer to add tracepoints
    to the gadget API.
=20=20=20=20
    While at that, also fix Kconfig dependencies to
    avoid randconfig build failures.
=20=20=20=20
    Signed-off-by: Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

diff --git a/drivers/usb/gadget/udc/udc-core.c b/drivers/usb/gadget/udc/udc=
-core.c
index 6e8300d6a737..d2f28bb6dbda 100644
=2D-- a/drivers/usb/gadget/udc/udc-core.c
+++ b/drivers/usb/gadget/udc/udc-core.c
@@ -59,6 +59,579 @@ static int udc_bind_to_driver(struct usb_udc *udc,
=20
 /* -----------------------------------------------------------------------=
-- */
=20
+/**
+ * usb_ep_set_maxpacket_limit - set maximum packet size limit for endpoint
+ * @ep:the endpoint being configured
+ * @maxpacket_limit:value of maximum packet size limit
+ *
+ * This function should be used only in UDC drivers to initialize endpoint
+ * (usually in probe function).
+ */
+void usb_ep_set_maxpacket_limit(struct usb_ep *ep,
+					      unsigned maxpacket_limit)
+{
+	ep->maxpacket_limit =3D maxpacket_limit;
+	ep->maxpacket =3D maxpacket_limit;
+}
+EXPORT_SYMBOL_GPL(usb_ep_set_maxpacket_limit);
+
+/**
+ * usb_ep_enable - configure endpoint, making it usable
+ * @ep:the endpoint being configured.  may not be the endpoint named "ep0".
+ *	drivers discover endpoints through the ep_list of a usb_gadget.
+ *
+ * When configurations are set, or when interface settings change, the dri=
ver
+ * will enable or disable the relevant endpoints.  while it is enabled, an
+ * endpoint may be used for i/o until the driver receives a disconnect() f=
rom
+ * the host or until the endpoint is disabled.
+ *
+ * the ep0 implementation (which calls this routine) must ensure that the
+ * hardware capabilities of each endpoint match the descriptor provided
+ * for it.  for example, an endpoint named "ep2in-bulk" would be usable
+ * for interrupt transfers as well as bulk, but it likely couldn't be used
+ * for iso transfers or for endpoint 14.  some endpoints are fully
+ * configurable, with more generic names like "ep-a".  (remember that for
+ * USB, "in" means "towards the USB master".)
+ *
+ * returns zero, or a negative error code.
+ */
+int usb_ep_enable(struct usb_ep *ep)
+{
+	int ret;
+
+	if (ep->enabled)
+		return 0;
+
+	ret =3D ep->ops->enable(ep, ep->desc);
+	if (ret)
+		return ret;
+
+	ep->enabled =3D true;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(usb_ep_enable);
+
+/**
+ * usb_ep_disable - endpoint is no longer usable
+ * @ep:the endpoint being unconfigured.  may not be the endpoint named "ep=
0".
+ *
+ * no other task may be using this endpoint when this is called.
+ * any pending and uncompleted requests will complete with status
+ * indicating disconnect (-ESHUTDOWN) before this call returns.
+ * gadget drivers must call usb_ep_enable() again before queueing
+ * requests to the endpoint.
+ *
+ * returns zero, or a negative error code.
+ */
+int usb_ep_disable(struct usb_ep *ep)
+{
+	int ret;
+
+	if (!ep->enabled)
+		return 0;
+
+	ret =3D ep->ops->disable(ep);
+	if (ret)
+		return ret;
+
+	ep->enabled =3D false;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(usb_ep_disable);
+
+/**
+ * usb_ep_alloc_request - allocate a request object to use with this endpo=
int
+ * @ep:the endpoint to be used with with the request
+ * @gfp_flags:GFP_* flags to use
+ *
+ * Request objects must be allocated with this call, since they normally
+ * need controller-specific setup and may even need endpoint-specific
+ * resources such as allocation of DMA descriptors.
+ * Requests may be submitted with usb_ep_queue(), and receive a single
+ * completion callback.  Free requests with usb_ep_free_request(), when
+ * they are no longer needed.
+ *
+ * Returns the request, or null if one could not be allocated.
+ */
+struct usb_request *usb_ep_alloc_request(struct usb_ep *ep,
+						       gfp_t gfp_flags)
+{
+	return ep->ops->alloc_request(ep, gfp_flags);
+}
+EXPORT_SYMBOL_GPL(usb_ep_alloc_request);
+
+/**
+ * usb_ep_free_request - frees a request object
+ * @ep:the endpoint associated with the request
+ * @req:the request being freed
+ *
+ * Reverses the effect of usb_ep_alloc_request().
+ * Caller guarantees the request is not queued, and that it will
+ * no longer be requeued (or otherwise used).
+ */
+void usb_ep_free_request(struct usb_ep *ep,
+				       struct usb_request *req)
+{
+	ep->ops->free_request(ep, req);
+}
+EXPORT_SYMBOL_GPL(usb_ep_free_request);
+
+/**
+ * usb_ep_queue - queues (submits) an I/O request to an endpoint.
+ * @ep:the endpoint associated with the request
+ * @req:the request being submitted
+ * @gfp_flags: GFP_* flags to use in case the lower level driver couldn't
+ *	pre-allocate all necessary memory with the request.
+ *
+ * This tells the device controller to perform the specified request throu=
gh
+ * that endpoint (reading or writing a buffer).  When the request complete=
s,
+ * including being canceled by usb_ep_dequeue(), the request's completion
+ * routine is called to return the request to the driver.  Any endpoint
+ * (except control endpoints like ep0) may have more than one transfer
+ * request queued; they complete in FIFO order.  Once a gadget driver
+ * submits a request, that request may not be examined or modified until it
+ * is given back to that driver through the completion callback.
+ *
+ * Each request is turned into one or more packets.  The controller driver
+ * never merges adjacent requests into the same packet.  OUT transfers
+ * will sometimes use data that's already buffered in the hardware.
+ * Drivers can rely on the fact that the first byte of the request's buffer
+ * always corresponds to the first byte of some USB packet, for both
+ * IN and OUT transfers.
+ *
+ * Bulk endpoints can queue any amount of data; the transfer is packetized
+ * automatically.  The last packet will be short if the request doesn't fi=
ll it
+ * out completely.  Zero length packets (ZLPs) should be avoided in portab=
le
+ * protocols since not all usb hardware can successfully handle zero length
+ * packets.  (ZLPs may be explicitly written, and may be implicitly writte=
n if
+ * the request 'zero' flag is set.)  Bulk endpoints may also be used
+ * for interrupt transfers; but the reverse is not true, and some endpoints
+ * won't support every interrupt transfer.  (Such as 768 byte packets.)
+ *
+ * Interrupt-only endpoints are less functional than bulk endpoints, for
+ * example by not supporting queueing or not handling buffers that are
+ * larger than the endpoint's maxpacket size.  They may also treat data
+ * toggle differently.
+ *
+ * Control endpoints ... after getting a setup() callback, the driver queu=
es
+ * one response (even if it would be zero length).  That enables the
+ * status ack, after transferring data as specified in the response.  Setup
+ * functions may return negative error codes to generate protocol stalls.
+ * (Note that some USB device controllers disallow protocol stall responses
+ * in some cases.)  When control responses are deferred (the response is
+ * written after the setup callback returns), then usb_ep_set_halt() may be
+ * used on ep0 to trigger protocol stalls.  Depending on the controller,
+ * it may not be possible to trigger a status-stage protocol stall when the
+ * data stage is over, that is, from within the response's completion
+ * routine.
+ *
+ * For periodic endpoints, like interrupt or isochronous ones, the usb host
+ * arranges to poll once per interval, and the gadget driver usually will
+ * have queued some data to transfer at that time.
+ *
+ * Returns zero, or a negative error code.  Endpoints that are not enabled
+ * report errors; errors will also be
+ * reported when the usb peripheral is disconnected.
+ */
+int usb_ep_queue(struct usb_ep *ep,
+			       struct usb_request *req, gfp_t gfp_flags)
+{
+	if (WARN_ON_ONCE(!ep->enabled && ep->address))
+		return -ESHUTDOWN;
+
+	return ep->ops->queue(ep, req, gfp_flags);
+}
+EXPORT_SYMBOL_GPL(usb_ep_queue);
+
+/**
+ * usb_ep_dequeue - dequeues (cancels, unlinks) an I/O request from an end=
point
+ * @ep:the endpoint associated with the request
+ * @req:the request being canceled
+ *
+ * If the request is still active on the endpoint, it is dequeued and its
+ * completion routine is called (with status -ECONNRESET); else a negative
+ * error code is returned. This is guaranteed to happen before the call to
+ * usb_ep_dequeue() returns.
+ *
+ * Note that some hardware can't clear out write fifos (to unlink the requ=
est
+ * at the head of the queue) except as part of disconnecting from usb. Such
+ * restrictions prevent drivers from supporting configuration changes,
+ * even to configuration zero (a "chapter 9" requirement).
+ */
+int usb_ep_dequeue(struct usb_ep *ep, struct usb_request *req)
+{
+	return ep->ops->dequeue(ep, req);
+}
+EXPORT_SYMBOL_GPL(usb_ep_dequeue);
+
+/**
+ * usb_ep_set_halt - sets the endpoint halt feature.
+ * @ep: the non-isochronous endpoint being stalled
+ *
+ * Use this to stall an endpoint, perhaps as an error report.
+ * Except for control endpoints,
+ * the endpoint stays halted (will not stream any data) until the host
+ * clears this feature; drivers may need to empty the endpoint's request
+ * queue first, to make sure no inappropriate transfers happen.
+ *
+ * Note that while an endpoint CLEAR_FEATURE will be invisible to the
+ * gadget driver, a SET_INTERFACE will not be.  To reset endpoints for the
+ * current altsetting, see usb_ep_clear_halt().  When switching altsetting=
s,
+ * it's simplest to use usb_ep_enable() or usb_ep_disable() for the endpoi=
nts.
+ *
+ * Returns zero, or a negative error code.  On success, this call sets
+ * underlying hardware state that blocks data transfers.
+ * Attempts to halt IN endpoints will fail (returning -EAGAIN) if any
+ * transfer requests are still queued, or if the controller hardware
+ * (usually a FIFO) still holds bytes that the host hasn't collected.
+ */
+int usb_ep_set_halt(struct usb_ep *ep)
+{
+	return ep->ops->set_halt(ep, 1);
+}
+EXPORT_SYMBOL_GPL(usb_ep_set_halt);
+
+/**
+ * usb_ep_clear_halt - clears endpoint halt, and resets toggle
+ * @ep:the bulk or interrupt endpoint being reset
+ *
+ * Use this when responding to the standard usb "set interface" request,
+ * for endpoints that aren't reconfigured, after clearing any other state
+ * in the endpoint's i/o queue.
+ *
+ * Returns zero, or a negative error code.  On success, this call clears
+ * the underlying hardware state reflecting endpoint halt and data toggle.
+ * Note that some hardware can't support this request (like pxa2xx_udc),
+ * and accordingly can't correctly implement interface altsettings.
+ */
+int usb_ep_clear_halt(struct usb_ep *ep)
+{
+	return ep->ops->set_halt(ep, 0);
+}
+EXPORT_SYMBOL_GPL(usb_ep_clear_halt);
+
+/**
+ * usb_ep_set_wedge - sets the halt feature and ignores clear requests
+ * @ep: the endpoint being wedged
+ *
+ * Use this to stall an endpoint and ignore CLEAR_FEATURE(HALT_ENDPOINT)
+ * requests. If the gadget driver clears the halt status, it will
+ * automatically unwedge the endpoint.
+ *
+ * Returns zero on success, else negative errno.
+ */
+int usb_ep_set_wedge(struct usb_ep *ep)
+{
+	if (ep->ops->set_wedge)
+		return ep->ops->set_wedge(ep);
+	else
+		return ep->ops->set_halt(ep, 1);
+}
+EXPORT_SYMBOL_GPL(usb_ep_set_wedge);
+
+/**
+ * usb_ep_fifo_status - returns number of bytes in fifo, or error
+ * @ep: the endpoint whose fifo status is being checked.
+ *
+ * FIFO endpoints may have "unclaimed data" in them in certain cases,
+ * such as after aborted transfers.  Hosts may not have collected all
+ * the IN data written by the gadget driver (and reported by a request
+ * completion).  The gadget driver may not have collected all the data
+ * written OUT to it by the host.  Drivers that need precise handling for
+ * fault reporting or recovery may need to use this call.
+ *
+ * This returns the number of such bytes in the fifo, or a negative
+ * errno if the endpoint doesn't use a FIFO or doesn't support such
+ * precise handling.
+ */
+int usb_ep_fifo_status(struct usb_ep *ep)
+{
+	if (ep->ops->fifo_status)
+		return ep->ops->fifo_status(ep);
+	else
+		return -EOPNOTSUPP;
+}
+EXPORT_SYMBOL_GPL(usb_ep_fifo_status);
+
+/**
+ * usb_ep_fifo_flush - flushes contents of a fifo
+ * @ep: the endpoint whose fifo is being flushed.
+ *
+ * This call may be used to flush the "unclaimed data" that may exist in
+ * an endpoint fifo after abnormal transaction terminations.  The call
+ * must never be used except when endpoint is not being used for any
+ * protocol translation.
+ */
+void usb_ep_fifo_flush(struct usb_ep *ep)
+{
+	if (ep->ops->fifo_flush)
+		ep->ops->fifo_flush(ep);
+}
+EXPORT_SYMBOL_GPL(usb_ep_fifo_flush);
+
+/* -----------------------------------------------------------------------=
-- */
+
+/**
+ * usb_gadget_frame_number - returns the current frame number
+ * @gadget: controller that reports the frame number
+ *
+ * Returns the usb frame number, normally eleven bits from a SOF packet,
+ * or negative errno if this device doesn't support this capability.
+ */
+int usb_gadget_frame_number(struct usb_gadget *gadget)
+{
+	return gadget->ops->get_frame(gadget);
+}
+EXPORT_SYMBOL_GPL(usb_gadget_frame_number);
+
+/**
+ * usb_gadget_wakeup - tries to wake up the host connected to this gadget
+ * @gadget: controller used to wake up the host
+ *
+ * Returns zero on success, else negative error code if the hardware
+ * doesn't support such attempts, or its support has not been enabled
+ * by the usb host.  Drivers must return device descriptors that report
+ * their ability to support this, or hosts won't enable it.
+ *
+ * This may also try to use SRP to wake the host and start enumeration,
+ * even if OTG isn't otherwise in use.  OTG devices may also start
+ * remote wakeup even when hosts don't explicitly enable it.
+ */
+int usb_gadget_wakeup(struct usb_gadget *gadget)
+{
+	if (!gadget->ops->wakeup)
+		return -EOPNOTSUPP;
+	return gadget->ops->wakeup(gadget);
+}
+EXPORT_SYMBOL_GPL(usb_gadget_wakeup);
+
+/**
+ * usb_gadget_set_selfpowered - sets the device selfpowered feature.
+ * @gadget:the device being declared as self-powered
+ *
+ * this affects the device status reported by the hardware driver
+ * to reflect that it now has a local power supply.
+ *
+ * returns zero on success, else negative errno.
+ */
+int usb_gadget_set_selfpowered(struct usb_gadget *gadget)
+{
+	if (!gadget->ops->set_selfpowered)
+		return -EOPNOTSUPP;
+	return gadget->ops->set_selfpowered(gadget, 1);
+}
+EXPORT_SYMBOL_GPL(usb_gadget_set_selfpowered);
+
+/**
+ * usb_gadget_clear_selfpowered - clear the device selfpowered feature.
+ * @gadget:the device being declared as bus-powered
+ *
+ * this affects the device status reported by the hardware driver.
+ * some hardware may not support bus-powered operation, in which
+ * case this feature's value can never change.
+ *
+ * returns zero on success, else negative errno.
+ */
+int usb_gadget_clear_selfpowered(struct usb_gadget *gadget)
+{
+	if (!gadget->ops->set_selfpowered)
+		return -EOPNOTSUPP;
+	return gadget->ops->set_selfpowered(gadget, 0);
+}
+EXPORT_SYMBOL_GPL(usb_gadget_clear_selfpowered);
+
+/**
+ * usb_gadget_vbus_connect - Notify controller that VBUS is powered
+ * @gadget:The device which now has VBUS power.
+ * Context: can sleep
+ *
+ * This call is used by a driver for an external transceiver (or GPIO)
+ * that detects a VBUS power session starting.  Common responses include
+ * resuming the controller, activating the D+ (or D-) pullup to let the
+ * host detect that a USB device is attached, and starting to draw power
+ * (8mA or possibly more, especially after SET_CONFIGURATION).
+ *
+ * Returns zero on success, else negative errno.
+ */
+int usb_gadget_vbus_connect(struct usb_gadget *gadget)
+{
+	if (!gadget->ops->vbus_session)
+		return -EOPNOTSUPP;
+	return gadget->ops->vbus_session(gadget, 1);
+}
+EXPORT_SYMBOL_GPL(usb_gadget_vbus_connect);
+
+/**
+ * usb_gadget_vbus_draw - constrain controller's VBUS power usage
+ * @gadget:The device whose VBUS usage is being described
+ * @mA:How much current to draw, in milliAmperes.  This should be twice
+ *	the value listed in the configuration descriptor bMaxPower field.
+ *
+ * This call is used by gadget drivers during SET_CONFIGURATION calls,
+ * reporting how much power the device may consume.  For example, this
+ * could affect how quickly batteries are recharged.
+ *
+ * Returns zero on success, else negative errno.
+ */
+int usb_gadget_vbus_draw(struct usb_gadget *gadget, unsigned mA)
+{
+	if (!gadget->ops->vbus_draw)
+		return -EOPNOTSUPP;
+	return gadget->ops->vbus_draw(gadget, mA);
+}
+EXPORT_SYMBOL_GPL(usb_gadget_vbus_draw);
+
+/**
+ * usb_gadget_vbus_disconnect - notify controller about VBUS session end
+ * @gadget:the device whose VBUS supply is being described
+ * Context: can sleep
+ *
+ * This call is used by a driver for an external transceiver (or GPIO)
+ * that detects a VBUS power session ending.  Common responses include
+ * reversing everything done in usb_gadget_vbus_connect().
+ *
+ * Returns zero on success, else negative errno.
+ */
+int usb_gadget_vbus_disconnect(struct usb_gadget *gadget)
+{
+	if (!gadget->ops->vbus_session)
+		return -EOPNOTSUPP;
+	return gadget->ops->vbus_session(gadget, 0);
+}
+EXPORT_SYMBOL_GPL(usb_gadget_vbus_disconnect);
+
+/**
+ * usb_gadget_connect - software-controlled connect to USB host
+ * @gadget:the peripheral being connected
+ *
+ * Enables the D+ (or potentially D-) pullup.  The host will start
+ * enumerating this gadget when the pullup is active and a VBUS session
+ * is active (the link is powered).  This pullup is always enabled unless
+ * usb_gadget_disconnect() has been used to disable it.
+ *
+ * Returns zero on success, else negative errno.
+ */
+int usb_gadget_connect(struct usb_gadget *gadget)
+{
+	int ret;
+
+	if (!gadget->ops->pullup)
+		return -EOPNOTSUPP;
+
+	if (gadget->deactivated) {
+		/*
+		 * If gadget is deactivated we only save new state.
+		 * Gadget will be connected automatically after activation.
+		 */
+		gadget->connected =3D true;
+		return 0;
+	}
+
+	ret =3D gadget->ops->pullup(gadget, 1);
+	if (!ret)
+		gadget->connected =3D 1;
+	return ret;
+}
+EXPORT_SYMBOL_GPL(usb_gadget_connect);
+
+/**
+ * usb_gadget_disconnect - software-controlled disconnect from USB host
+ * @gadget:the peripheral being disconnected
+ *
+ * Disables the D+ (or potentially D-) pullup, which the host may see
+ * as a disconnect (when a VBUS session is active).  Not all systems
+ * support software pullup controls.
+ *
+ * Returns zero on success, else negative errno.
+ */
+int usb_gadget_disconnect(struct usb_gadget *gadget)
+{
+	int ret;
+
+	if (!gadget->ops->pullup)
+		return -EOPNOTSUPP;
+
+	if (gadget->deactivated) {
+		/*
+		 * If gadget is deactivated we only save new state.
+		 * Gadget will stay disconnected after activation.
+		 */
+		gadget->connected =3D false;
+		return 0;
+	}
+
+	ret =3D gadget->ops->pullup(gadget, 0);
+	if (!ret)
+		gadget->connected =3D 0;
+	return ret;
+}
+EXPORT_SYMBOL_GPL(usb_gadget_disconnect);
+
+/**
+ * usb_gadget_deactivate - deactivate function which is not ready to work
+ * @gadget: the peripheral being deactivated
+ *
+ * This routine may be used during the gadget driver bind() call to prevent
+ * the peripheral from ever being visible to the USB host, unless later
+ * usb_gadget_activate() is called.  For example, user mode components may
+ * need to be activated before the system can talk to hosts.
+ *
+ * Returns zero on success, else negative errno.
+ */
+int usb_gadget_deactivate(struct usb_gadget *gadget)
+{
+	int ret;
+
+	if (gadget->deactivated)
+		return 0;
+
+	if (gadget->connected) {
+		ret =3D usb_gadget_disconnect(gadget);
+		if (ret)
+			return ret;
+		/*
+		 * If gadget was being connected before deactivation, we want
+		 * to reconnect it in usb_gadget_activate().
+		 */
+		gadget->connected =3D true;
+	}
+	gadget->deactivated =3D true;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(usb_gadget_deactivate);
+
+/**
+ * usb_gadget_activate - activate function which is not ready to work
+ * @gadget: the peripheral being activated
+ *
+ * This routine activates gadget which was previously deactivated with
+ * usb_gadget_deactivate() call. It calls usb_gadget_connect() if needed.
+ *
+ * Returns zero on success, else negative errno.
+ */
+int usb_gadget_activate(struct usb_gadget *gadget)
+{
+	if (!gadget->deactivated)
+		return 0;
+
+	gadget->deactivated =3D false;
+
+	/*
+	 * If gadget has been connected before deactivation, or became connected
+	 * while it was being deactivated, we call usb_gadget_connect().
+	 */
+	if (gadget->connected)
+		return usb_gadget_connect(gadget);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(usb_gadget_activate);
+
+/* -----------------------------------------------------------------------=
-- */
+
 #ifdef	CONFIG_HAS_DMA
=20
 int usb_gadget_map_request_by_dev(struct device *dev,
diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index d8f5674809e8..2e710a4cca52 100644
=2D-- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -180,7 +180,7 @@ config USB_EHCI_MXC
 config USB_EHCI_HCD_OMAP
 	tristate "EHCI support for OMAP3 and later chips"
 	depends on ARCH_OMAP
=2D	select NOP_USB_XCEIV
+	depends on NOP_USB_XCEIV
 	default y
 	---help---
 	  Enables support for the on-chip EHCI controller on
diff --git a/drivers/usb/phy/Kconfig b/drivers/usb/phy/Kconfig
index c6904742e2aa..ca509448b844 100644
=2D-- a/drivers/usb/phy/Kconfig
+++ b/drivers/usb/phy/Kconfig
@@ -43,7 +43,7 @@ config ISP1301_OMAP
 config KEYSTONE_USB_PHY
 	tristate "Keystone USB PHY Driver"
 	depends on ARCH_KEYSTONE || COMPILE_TEST
=2D	select NOP_USB_XCEIV
+	depends on NOP_USB_XCEIV
 	help
 	  Enable this to support Keystone USB phy. This driver provides
 	  interface to interact with USB 2.0 and USB 3.0 PHY that is part
@@ -51,6 +51,7 @@ config KEYSTONE_USB_PHY
=20
 config NOP_USB_XCEIV
 	tristate "NOP USB Transceiver Driver"
+	depends on USB_GADGET || !USB_GADGET # if USB_GADGET=3Dm, NOP can't be bu=
ilt-in
 	select USB_PHY
 	help
 	  This driver is to be used by all the usb transceiver which are either
@@ -63,9 +64,9 @@ config AM335X_CONTROL_USB
 config AM335X_PHY_USB
 	tristate "AM335x USB PHY Driver"
 	depends on ARM || COMPILE_TEST
+	depends on NOP_USB_XCEIV
 	select USB_PHY
 	select AM335X_CONTROL_USB
=2D	select NOP_USB_XCEIV
 	select USB_COMMON
 	help
 	  This driver provides PHY support for that phy which part for the
diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index 457651bf45b0..4cfc1ea352bb 100644
=2D-- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -228,307 +228,49 @@ struct usb_ep {
=20
 /*------------------------------------------------------------------------=
-*/
=20
=2D/**
=2D * usb_ep_set_maxpacket_limit - set maximum packet size limit for endpoi=
nt
=2D * @ep:the endpoint being configured
=2D * @maxpacket_limit:value of maximum packet size limit
=2D *
=2D * This function should be used only in UDC drivers to initialize endpoi=
nt
=2D * (usually in probe function).
=2D */
+#if IS_ENABLED(CONFIG_USB_GADGET)
+void usb_ep_set_maxpacket_limit(struct usb_ep *ep, unsigned maxpacket_limi=
t);
+int usb_ep_enable(struct usb_ep *ep);
+int usb_ep_disable(struct usb_ep *ep);
+struct usb_request *usb_ep_alloc_request(struct usb_ep *ep, gfp_t gfp_flag=
s);
+void usb_ep_free_request(struct usb_ep *ep, struct usb_request *req);
+int usb_ep_queue(struct usb_ep *ep, struct usb_request *req, gfp_t gfp_fla=
gs);
+int usb_ep_dequeue(struct usb_ep *ep, struct usb_request *req);
+int usb_ep_set_halt(struct usb_ep *ep);
+int usb_ep_clear_halt(struct usb_ep *ep);
+int usb_ep_set_wedge(struct usb_ep *ep);
+int usb_ep_fifo_status(struct usb_ep *ep);
+void usb_ep_fifo_flush(struct usb_ep *ep);
+#else
 static inline void usb_ep_set_maxpacket_limit(struct usb_ep *ep,
=2D					      unsigned maxpacket_limit)
=2D{
=2D	ep->maxpacket_limit =3D maxpacket_limit;
=2D	ep->maxpacket =3D maxpacket_limit;
=2D}
=2D
=2D/**
=2D * usb_ep_enable - configure endpoint, making it usable
=2D * @ep:the endpoint being configured.  may not be the endpoint named "ep=
0".
=2D *	drivers discover endpoints through the ep_list of a usb_gadget.
=2D *
=2D * When configurations are set, or when interface settings change, the d=
river
=2D * will enable or disable the relevant endpoints.  while it is enabled, =
an
=2D * endpoint may be used for i/o until the driver receives a disconnect()=
 from
=2D * the host or until the endpoint is disabled.
=2D *
=2D * the ep0 implementation (which calls this routine) must ensure that the
=2D * hardware capabilities of each endpoint match the descriptor provided
=2D * for it.  for example, an endpoint named "ep2in-bulk" would be usable
=2D * for interrupt transfers as well as bulk, but it likely couldn't be us=
ed
=2D * for iso transfers or for endpoint 14.  some endpoints are fully
=2D * configurable, with more generic names like "ep-a".  (remember that for
=2D * USB, "in" means "towards the USB master".)
=2D *
=2D * returns zero, or a negative error code.
=2D */
+		unsigned maxpacket_limit)
+{ }
 static inline int usb_ep_enable(struct usb_ep *ep)
=2D{
=2D	int ret;
=2D
=2D	if (ep->enabled)
=2D		return 0;
=2D
=2D	ret =3D ep->ops->enable(ep, ep->desc);
=2D	if (ret)
=2D		return ret;
=2D
=2D	ep->enabled =3D true;
=2D
=2D	return 0;
=2D}
=2D
=2D/**
=2D * usb_ep_disable - endpoint is no longer usable
=2D * @ep:the endpoint being unconfigured.  may not be the endpoint named "=
ep0".
=2D *
=2D * no other task may be using this endpoint when this is called.
=2D * any pending and uncompleted requests will complete with status
=2D * indicating disconnect (-ESHUTDOWN) before this call returns.
=2D * gadget drivers must call usb_ep_enable() again before queueing
=2D * requests to the endpoint.
=2D *
=2D * returns zero, or a negative error code.
=2D */
+{ return 0; }
 static inline int usb_ep_disable(struct usb_ep *ep)
=2D{
=2D	int ret;
=2D
=2D	if (!ep->enabled)
=2D		return 0;
=2D
=2D	ret =3D ep->ops->disable(ep);
=2D	if (ret)
=2D		return ret;
=2D
=2D	ep->enabled =3D false;
=2D
=2D	return 0;
=2D}
=2D
=2D/**
=2D * usb_ep_alloc_request - allocate a request object to use with this end=
point
=2D * @ep:the endpoint to be used with with the request
=2D * @gfp_flags:GFP_* flags to use
=2D *
=2D * Request objects must be allocated with this call, since they normally
=2D * need controller-specific setup and may even need endpoint-specific
=2D * resources such as allocation of DMA descriptors.
=2D * Requests may be submitted with usb_ep_queue(), and receive a single
=2D * completion callback.  Free requests with usb_ep_free_request(), when
=2D * they are no longer needed.
=2D *
=2D * Returns the request, or null if one could not be allocated.
=2D */
+{ return 0; }
 static inline struct usb_request *usb_ep_alloc_request(struct usb_ep *ep,
=2D						       gfp_t gfp_flags)
=2D{
=2D	return ep->ops->alloc_request(ep, gfp_flags);
=2D}
=2D
=2D/**
=2D * usb_ep_free_request - frees a request object
=2D * @ep:the endpoint associated with the request
=2D * @req:the request being freed
=2D *
=2D * Reverses the effect of usb_ep_alloc_request().
=2D * Caller guarantees the request is not queued, and that it will
=2D * no longer be requeued (or otherwise used).
=2D */
+		gfp_t gfp_flags)
+{ return NULL; }
 static inline void usb_ep_free_request(struct usb_ep *ep,
=2D				       struct usb_request *req)
=2D{
=2D	ep->ops->free_request(ep, req);
=2D}
=2D
=2D/**
=2D * usb_ep_queue - queues (submits) an I/O request to an endpoint.
=2D * @ep:the endpoint associated with the request
=2D * @req:the request being submitted
=2D * @gfp_flags: GFP_* flags to use in case the lower level driver couldn't
=2D *	pre-allocate all necessary memory with the request.
=2D *
=2D * This tells the device controller to perform the specified request thr=
ough
=2D * that endpoint (reading or writing a buffer).  When the request comple=
tes,
=2D * including being canceled by usb_ep_dequeue(), the request's completion
=2D * routine is called to return the request to the driver.  Any endpoint
=2D * (except control endpoints like ep0) may have more than one transfer
=2D * request queued; they complete in FIFO order.  Once a gadget driver
=2D * submits a request, that request may not be examined or modified until=
 it
=2D * is given back to that driver through the completion callback.
=2D *
=2D * Each request is turned into one or more packets.  The controller driv=
er
=2D * never merges adjacent requests into the same packet.  OUT transfers
=2D * will sometimes use data that's already buffered in the hardware.
=2D * Drivers can rely on the fact that the first byte of the request's buf=
fer
=2D * always corresponds to the first byte of some USB packet, for both
=2D * IN and OUT transfers.
=2D *
=2D * Bulk endpoints can queue any amount of data; the transfer is packetiz=
ed
=2D * automatically.  The last packet will be short if the request doesn't =
fill it
=2D * out completely.  Zero length packets (ZLPs) should be avoided in port=
able
=2D * protocols since not all usb hardware can successfully handle zero len=
gth
=2D * packets.  (ZLPs may be explicitly written, and may be implicitly writ=
ten if
=2D * the request 'zero' flag is set.)  Bulk endpoints may also be used
=2D * for interrupt transfers; but the reverse is not true, and some endpoi=
nts
=2D * won't support every interrupt transfer.  (Such as 768 byte packets.)
=2D *
=2D * Interrupt-only endpoints are less functional than bulk endpoints, for
=2D * example by not supporting queueing or not handling buffers that are
=2D * larger than the endpoint's maxpacket size.  They may also treat data
=2D * toggle differently.
=2D *
=2D * Control endpoints ... after getting a setup() callback, the driver qu=
eues
=2D * one response (even if it would be zero length).  That enables the
=2D * status ack, after transferring data as specified in the response.  Se=
tup
=2D * functions may return negative error codes to generate protocol stalls.
=2D * (Note that some USB device controllers disallow protocol stall respon=
ses
=2D * in some cases.)  When control responses are deferred (the response is
=2D * written after the setup callback returns), then usb_ep_set_halt() may=
 be
=2D * used on ep0 to trigger protocol stalls.  Depending on the controller,
=2D * it may not be possible to trigger a status-stage protocol stall when =
the
=2D * data stage is over, that is, from within the response's completion
=2D * routine.
=2D *
=2D * For periodic endpoints, like interrupt or isochronous ones, the usb h=
ost
=2D * arranges to poll once per interval, and the gadget driver usually will
=2D * have queued some data to transfer at that time.
=2D *
=2D * Returns zero, or a negative error code.  Endpoints that are not enabl=
ed
=2D * report errors; errors will also be
=2D * reported when the usb peripheral is disconnected.
=2D */
=2Dstatic inline int usb_ep_queue(struct usb_ep *ep,
=2D			       struct usb_request *req, gfp_t gfp_flags)
=2D{
=2D	if (WARN_ON_ONCE(!ep->enabled && ep->address))
=2D		return -ESHUTDOWN;
=2D
=2D	return ep->ops->queue(ep, req, gfp_flags);
=2D}
=2D
=2D/**
=2D * usb_ep_dequeue - dequeues (cancels, unlinks) an I/O request from an e=
ndpoint
=2D * @ep:the endpoint associated with the request
=2D * @req:the request being canceled
=2D *
=2D * If the request is still active on the endpoint, it is dequeued and its
=2D * completion routine is called (with status -ECONNRESET); else a negati=
ve
=2D * error code is returned. This is guaranteed to happen before the call =
to
=2D * usb_ep_dequeue() returns.
=2D *
=2D * Note that some hardware can't clear out write fifos (to unlink the re=
quest
=2D * at the head of the queue) except as part of disconnecting from usb. S=
uch
=2D * restrictions prevent drivers from supporting configuration changes,
=2D * even to configuration zero (a "chapter 9" requirement).
=2D */
+		struct usb_request *req)
+{ }
+static inline int usb_ep_queue(struct usb_ep *ep, struct usb_request *req,
+		gfp_t gfp_flags)
+{ return 0; }
 static inline int usb_ep_dequeue(struct usb_ep *ep, struct usb_request *re=
q)
=2D{
=2D	return ep->ops->dequeue(ep, req);
=2D}
=2D
=2D/**
=2D * usb_ep_set_halt - sets the endpoint halt feature.
=2D * @ep: the non-isochronous endpoint being stalled
=2D *
=2D * Use this to stall an endpoint, perhaps as an error report.
=2D * Except for control endpoints,
=2D * the endpoint stays halted (will not stream any data) until the host
=2D * clears this feature; drivers may need to empty the endpoint's request
=2D * queue first, to make sure no inappropriate transfers happen.
=2D *
=2D * Note that while an endpoint CLEAR_FEATURE will be invisible to the
=2D * gadget driver, a SET_INTERFACE will not be.  To reset endpoints for t=
he
=2D * current altsetting, see usb_ep_clear_halt().  When switching altsetti=
ngs,
=2D * it's simplest to use usb_ep_enable() or usb_ep_disable() for the endp=
oints.
=2D *
=2D * Returns zero, or a negative error code.  On success, this call sets
=2D * underlying hardware state that blocks data transfers.
=2D * Attempts to halt IN endpoints will fail (returning -EAGAIN) if any
=2D * transfer requests are still queued, or if the controller hardware
=2D * (usually a FIFO) still holds bytes that the host hasn't collected.
=2D */
+{ return 0; }
 static inline int usb_ep_set_halt(struct usb_ep *ep)
=2D{
=2D	return ep->ops->set_halt(ep, 1);
=2D}
=2D
=2D/**
=2D * usb_ep_clear_halt - clears endpoint halt, and resets toggle
=2D * @ep:the bulk or interrupt endpoint being reset
=2D *
=2D * Use this when responding to the standard usb "set interface" request,
=2D * for endpoints that aren't reconfigured, after clearing any other state
=2D * in the endpoint's i/o queue.
=2D *
=2D * Returns zero, or a negative error code.  On success, this call clears
=2D * the underlying hardware state reflecting endpoint halt and data toggl=
e.
=2D * Note that some hardware can't support this request (like pxa2xx_udc),
=2D * and accordingly can't correctly implement interface altsettings.
=2D */
+{ return 0; }
 static inline int usb_ep_clear_halt(struct usb_ep *ep)
=2D{
=2D	return ep->ops->set_halt(ep, 0);
=2D}
=2D
=2D/**
=2D * usb_ep_set_wedge - sets the halt feature and ignores clear requests
=2D * @ep: the endpoint being wedged
=2D *
=2D * Use this to stall an endpoint and ignore CLEAR_FEATURE(HALT_ENDPOINT)
=2D * requests. If the gadget driver clears the halt status, it will
=2D * automatically unwedge the endpoint.
=2D *
=2D * Returns zero on success, else negative errno.
=2D */
=2Dstatic inline int
=2Dusb_ep_set_wedge(struct usb_ep *ep)
=2D{
=2D	if (ep->ops->set_wedge)
=2D		return ep->ops->set_wedge(ep);
=2D	else
=2D		return ep->ops->set_halt(ep, 1);
=2D}
=2D
=2D/**
=2D * usb_ep_fifo_status - returns number of bytes in fifo, or error
=2D * @ep: the endpoint whose fifo status is being checked.
=2D *
=2D * FIFO endpoints may have "unclaimed data" in them in certain cases,
=2D * such as after aborted transfers.  Hosts may not have collected all
=2D * the IN data written by the gadget driver (and reported by a request
=2D * completion).  The gadget driver may not have collected all the data
=2D * written OUT to it by the host.  Drivers that need precise handling for
=2D * fault reporting or recovery may need to use this call.
=2D *
=2D * This returns the number of such bytes in the fifo, or a negative
=2D * errno if the endpoint doesn't use a FIFO or doesn't support such
=2D * precise handling.
=2D */
+{ return 0; }
+static inline int usb_ep_set_wedge(struct usb_ep *ep)
+{ return 0; }
 static inline int usb_ep_fifo_status(struct usb_ep *ep)
=2D{
=2D	if (ep->ops->fifo_status)
=2D		return ep->ops->fifo_status(ep);
=2D	else
=2D		return -EOPNOTSUPP;
=2D}
=2D
=2D/**
=2D * usb_ep_fifo_flush - flushes contents of a fifo
=2D * @ep: the endpoint whose fifo is being flushed.
=2D *
=2D * This call may be used to flush the "unclaimed data" that may exist in
=2D * an endpoint fifo after abnormal transaction terminations.  The call
=2D * must never be used except when endpoint is not being used for any
=2D * protocol translation.
=2D */
+{ return 0; }
 static inline void usb_ep_fifo_flush(struct usb_ep *ep)
=2D{
=2D	if (ep->ops->fifo_flush)
=2D		ep->ops->fifo_flush(ep);
=2D}
=2D
+{ }
+#endif /* USB_GADGET */
=20
 /*------------------------------------------------------------------------=
-*/
=20
@@ -760,251 +502,19 @@ static inline int gadget_is_otg(struct usb_gadget *g)
 #endif
 }
=20
=2D/**
=2D * usb_gadget_frame_number - returns the current frame number
=2D * @gadget: controller that reports the frame number
=2D *
=2D * Returns the usb frame number, normally eleven bits from a SOF packet,
=2D * or negative errno if this device doesn't support this capability.
=2D */
=2Dstatic inline int usb_gadget_frame_number(struct usb_gadget *gadget)
=2D{
=2D	return gadget->ops->get_frame(gadget);
=2D}
=2D
=2D/**
=2D * usb_gadget_wakeup - tries to wake up the host connected to this gadget
=2D * @gadget: controller used to wake up the host
=2D *
=2D * Returns zero on success, else negative error code if the hardware
=2D * doesn't support such attempts, or its support has not been enabled
=2D * by the usb host.  Drivers must return device descriptors that report
=2D * their ability to support this, or hosts won't enable it.
=2D *
=2D * This may also try to use SRP to wake the host and start enumeration,
=2D * even if OTG isn't otherwise in use.  OTG devices may also start
=2D * remote wakeup even when hosts don't explicitly enable it.
=2D */
=2Dstatic inline int usb_gadget_wakeup(struct usb_gadget *gadget)
=2D{
=2D	if (!gadget->ops->wakeup)
=2D		return -EOPNOTSUPP;
=2D	return gadget->ops->wakeup(gadget);
=2D}
=2D
=2D/**
=2D * usb_gadget_set_selfpowered - sets the device selfpowered feature.
=2D * @gadget:the device being declared as self-powered
=2D *
=2D * this affects the device status reported by the hardware driver
=2D * to reflect that it now has a local power supply.
=2D *
=2D * returns zero on success, else negative errno.
=2D */
=2Dstatic inline int usb_gadget_set_selfpowered(struct usb_gadget *gadget)
=2D{
=2D	if (!gadget->ops->set_selfpowered)
=2D		return -EOPNOTSUPP;
=2D	return gadget->ops->set_selfpowered(gadget, 1);
=2D}
=2D
=2D/**
=2D * usb_gadget_clear_selfpowered - clear the device selfpowered feature.
=2D * @gadget:the device being declared as bus-powered
=2D *
=2D * this affects the device status reported by the hardware driver.
=2D * some hardware may not support bus-powered operation, in which
=2D * case this feature's value can never change.
=2D *
=2D * returns zero on success, else negative errno.
=2D */
=2Dstatic inline int usb_gadget_clear_selfpowered(struct usb_gadget *gadget)
=2D{
=2D	if (!gadget->ops->set_selfpowered)
=2D		return -EOPNOTSUPP;
=2D	return gadget->ops->set_selfpowered(gadget, 0);
=2D}
=2D
=2D/**
=2D * usb_gadget_vbus_connect - Notify controller that VBUS is powered
=2D * @gadget:The device which now has VBUS power.
=2D * Context: can sleep
=2D *
=2D * This call is used by a driver for an external transceiver (or GPIO)
=2D * that detects a VBUS power session starting.  Common responses include
=2D * resuming the controller, activating the D+ (or D-) pullup to let the
=2D * host detect that a USB device is attached, and starting to draw power
=2D * (8mA or possibly more, especially after SET_CONFIGURATION).
=2D *
=2D * Returns zero on success, else negative errno.
=2D */
=2Dstatic inline int usb_gadget_vbus_connect(struct usb_gadget *gadget)
=2D{
=2D	if (!gadget->ops->vbus_session)
=2D		return -EOPNOTSUPP;
=2D	return gadget->ops->vbus_session(gadget, 1);
=2D}
=2D
=2D/**
=2D * usb_gadget_vbus_draw - constrain controller's VBUS power usage
=2D * @gadget:The device whose VBUS usage is being described
=2D * @mA:How much current to draw, in milliAmperes.  This should be twice
=2D *	the value listed in the configuration descriptor bMaxPower field.
=2D *
=2D * This call is used by gadget drivers during SET_CONFIGURATION calls,
=2D * reporting how much power the device may consume.  For example, this
=2D * could affect how quickly batteries are recharged.
=2D *
=2D * Returns zero on success, else negative errno.
=2D */
=2Dstatic inline int usb_gadget_vbus_draw(struct usb_gadget *gadget, unsign=
ed mA)
=2D{
=2D	if (!gadget->ops->vbus_draw)
=2D		return -EOPNOTSUPP;
=2D	return gadget->ops->vbus_draw(gadget, mA);
=2D}
=2D
=2D/**
=2D * usb_gadget_vbus_disconnect - notify controller about VBUS session end
=2D * @gadget:the device whose VBUS supply is being described
=2D * Context: can sleep
=2D *
=2D * This call is used by a driver for an external transceiver (or GPIO)
=2D * that detects a VBUS power session ending.  Common responses include
=2D * reversing everything done in usb_gadget_vbus_connect().
=2D *
=2D * Returns zero on success, else negative errno.
=2D */
=2Dstatic inline int usb_gadget_vbus_disconnect(struct usb_gadget *gadget)
=2D{
=2D	if (!gadget->ops->vbus_session)
=2D		return -EOPNOTSUPP;
=2D	return gadget->ops->vbus_session(gadget, 0);
=2D}
=2D
=2D/**
=2D * usb_gadget_connect - software-controlled connect to USB host
=2D * @gadget:the peripheral being connected
=2D *
=2D * Enables the D+ (or potentially D-) pullup.  The host will start
=2D * enumerating this gadget when the pullup is active and a VBUS session
=2D * is active (the link is powered).  This pullup is always enabled unless
=2D * usb_gadget_disconnect() has been used to disable it.
=2D *
=2D * Returns zero on success, else negative errno.
=2D */
=2Dstatic inline int usb_gadget_connect(struct usb_gadget *gadget)
=2D{
=2D	int ret;
=2D
=2D	if (!gadget->ops->pullup)
=2D		return -EOPNOTSUPP;
=2D
=2D	if (gadget->deactivated) {
=2D		/*
=2D		 * If gadget is deactivated we only save new state.
=2D		 * Gadget will be connected automatically after activation.
=2D		 */
=2D		gadget->connected =3D true;
=2D		return 0;
=2D	}
=2D
=2D	ret =3D gadget->ops->pullup(gadget, 1);
=2D	if (!ret)
=2D		gadget->connected =3D 1;
=2D	return ret;
=2D}
=2D
=2D/**
=2D * usb_gadget_disconnect - software-controlled disconnect from USB host
=2D * @gadget:the peripheral being disconnected
=2D *
=2D * Disables the D+ (or potentially D-) pullup, which the host may see
=2D * as a disconnect (when a VBUS session is active).  Not all systems
=2D * support software pullup controls.
=2D *
=2D * Returns zero on success, else negative errno.
=2D */
=2Dstatic inline int usb_gadget_disconnect(struct usb_gadget *gadget)
=2D{
=2D	int ret;
=2D
=2D	if (!gadget->ops->pullup)
=2D		return -EOPNOTSUPP;
=2D
=2D	if (gadget->deactivated) {
=2D		/*
=2D		 * If gadget is deactivated we only save new state.
=2D		 * Gadget will stay disconnected after activation.
=2D		 */
=2D		gadget->connected =3D false;
=2D		return 0;
=2D	}
=2D
=2D	ret =3D gadget->ops->pullup(gadget, 0);
=2D	if (!ret)
=2D		gadget->connected =3D 0;
=2D	return ret;
=2D}
=2D
=2D/**
=2D * usb_gadget_deactivate - deactivate function which is not ready to work
=2D * @gadget: the peripheral being deactivated
=2D *
=2D * This routine may be used during the gadget driver bind() call to prev=
ent
=2D * the peripheral from ever being visible to the USB host, unless later
=2D * usb_gadget_activate() is called.  For example, user mode components m=
ay
=2D * need to be activated before the system can talk to hosts.
=2D *
=2D * Returns zero on success, else negative errno.
=2D */
=2Dstatic inline int usb_gadget_deactivate(struct usb_gadget *gadget)
=2D{
=2D	int ret;
=2D
=2D	if (gadget->deactivated)
=2D		return 0;
=2D
=2D	if (gadget->connected) {
=2D		ret =3D usb_gadget_disconnect(gadget);
=2D		if (ret)
=2D			return ret;
=2D		/*
=2D		 * If gadget was being connected before deactivation, we want
=2D		 * to reconnect it in usb_gadget_activate().
=2D		 */
=2D		gadget->connected =3D true;
=2D	}
=2D	gadget->deactivated =3D true;
=2D
=2D	return 0;
=2D}
=2D
=2D/**
=2D * usb_gadget_activate - activate function which is not ready to work
=2D * @gadget: the peripheral being activated
=2D *
=2D * This routine activates gadget which was previously deactivated with
=2D * usb_gadget_deactivate() call. It calls usb_gadget_connect() if needed.
=2D *
=2D * Returns zero on success, else negative errno.
=2D */
=2Dstatic inline int usb_gadget_activate(struct usb_gadget *gadget)
=2D{
=2D	if (!gadget->deactivated)
=2D		return 0;
=2D
=2D	gadget->deactivated =3D false;
=2D
=2D	/*
=2D	 * If gadget has been connected before deactivation, or became connected
=2D	 * while it was being deactivated, we call usb_gadget_connect().
=2D	 */
=2D	if (gadget->connected)
=2D		return usb_gadget_connect(gadget);
+/*------------------------------------------------------------------------=
-*/
=20
=2D	return 0;
=2D}
+int usb_gadget_frame_number(struct usb_gadget *gadget);
+int usb_gadget_wakeup(struct usb_gadget *gadget);
+int usb_gadget_set_selfpowered(struct usb_gadget *gadget);
+int usb_gadget_clear_selfpowered(struct usb_gadget *gadget);
+int usb_gadget_vbus_connect(struct usb_gadget *gadget);
+int usb_gadget_vbus_draw(struct usb_gadget *gadget, unsigned mA);
+int usb_gadget_vbus_disconnect(struct usb_gadget *gadget);
+int usb_gadget_connect(struct usb_gadget *gadget);
+int usb_gadget_disconnect(struct usb_gadget *gadget);
+int usb_gadget_deactivate(struct usb_gadget *gadget);
+int usb_gadget_activate(struct usb_gadget *gadget);
=20
 /*------------------------------------------------------------------------=
-*/
=20


=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXVqBtAAoJEIaOsuA1yqREk2oP/2/y0mh3NkHQA9+gpBWZH0l2
L+lpK1VomL/xZqQGYM9zawT1tM1RQ+5v//A2lEhjZckyI2kw1cyyVcz+H3Hn38L5
YFOPt8x4jKdku4jl6gntAccRMcjO8FLFWqMr07WfNz6a0A8yJkFMog53I3y7Nyie
c3T3mTUnZo2CvImiaGMjG1EMm1BRu+gjhXGeBuaWnUk/pO3JE1vNok85w+RXYhQE
Mnuwgi+pVUM/+YaugZlA3L9MDcr3olLPPYOSK7L3F03aYIUMi0X28bd4ugvQ5P9y
XaT4/GzqsQehNUqVtSfV6TYtYQXDJwM8vOd9MXXtmKlfNdSO8EYi6BLXpTrHj+gw
fJ++czotTO1lffBv4y7QN0Mc0mUr08BtlXi9a5z/1vZFkN4Q8NOIj8l6gEaTeHgG
/jKF8Z4Jua1nGTmRlbl0glyhRH/A+VjWmJHOdpGSSbA2HpMwBCkV6vo3yl2tagr4
VRogj4Vyq/jXLZzWv5kRwV3THRAZb++wZwzDrdlIsy/pOJThX/f9YhHkjjvHruLu
5SbhRNEpa8CT/mY3usWyGR6Q88RCmG8BLq/Lj+MFbGOb8m+PrP+4+Va96TGC2Q9C
eHKZRWinwqWLMKmeIn2ewOVxQaaH7o4i3pATKqqGsZyvbxZsUxBHHtZWQngtBUCu
HQL2q/G8JNEPQxz7MOdQ
=ZnFh
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
